import 'package:crmacsinsights/Core/Utils/common.dart';
import 'package:crmacsinsights/Features/CreatePatient/Model/LeadStatusResponseModel.dart';
import 'package:crmacsinsights/Features/CreatePatient/Model/leadsResponseModel.dart';
import 'package:crmacsinsights/Features/CreatePatient/Repositoy/leadRepository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Model/CreateLeadResponseModel.dart';
import '../Model/SingleLeadResponseModel.dart';

class PatientController extends GetxController {
  final PatientRepository patientRepository = PatientRepository();


  RxBool isLoading = false.obs;
  final RxnInt selectedMonth = RxnInt();
  final RxnInt selectedYear = RxnInt();
  Rx<LeadsResponseModel> patientResponse = LeadsResponseModel().obs;
  final RxList<Leads> allPatientsList = <Leads>[].obs;
  final RxList<Leads> patientsList = <Leads>[].obs;
  final searchController = TextEditingController();
  RxString errorMessage = ''.obs;
  Rx<SinglePatientResponseModel> leadDetails = SinglePatientResponseModel().obs;

  RxString selectedPatientStatus = ''.obs;
  RxString selectedStatusId = ''.obs;
  RxList<String> statusList = <String>[].obs;
  RxList<PatientStatus> statusWithIds = <PatientStatus>[].obs;

  RxList<Leads> filteredPatientsList = <Leads>[].obs;
  final startDate = Rxn<String>();
  final endDate = Rxn<String>();
  final selectedStatus = Rxn<String>();

  void resetFilters() {
    startDate.value = null;
    endDate.value = null;
    selectedStatus.value = null;
    selectedMonth.value = null;
    selectedYear.value = null;
    refreshPatients();
  }
  void applyFilters() {
    final filtered = allPatientsList.where((patient) {
      bool matchesDate = true;
      bool matchesStatus = true;
      bool matchesMonth = true;

      // Date range filter
      if (startDate.value != null && endDate.value != null && patient.createdAt != null) {
        final createdAt = DateTime.tryParse(patient.createdAt!);
        if (createdAt != null) {
          final start = DateTime.parse(startDate.value!);
          final end = DateTime.parse(endDate.value!).add(Duration(days: 1));
          matchesDate = createdAt.isAfter(start.subtract(Duration(seconds: 1))) && createdAt.isBefore(end);
        } else {
          matchesDate = false;
        }
      }

      // Status filter
      if (selectedStatus.value != null && selectedStatus.value!.isNotEmpty) {
        matchesStatus = patient.status?.name == selectedStatus.value;
      }

      // Month filter
      if (selectedMonth.value != null && selectedYear.value != null && patient.createdAt != null) {
        final createdAt = DateTime.tryParse(patient.createdAt!);
        if (createdAt != null) {
          matchesMonth = createdAt.month == selectedMonth.value && createdAt.year == selectedYear.value;
        } else {
          matchesMonth = false;
        }
      }

      return matchesDate && matchesStatus && matchesMonth;
    }).toList();

    patientsList.value = filtered;
  }

  @override
  void onInit() {
    super.onInit();
    getPatients();
    getPatientStatus();
  }

  void filterPatients(String query) {
    if (query.trim().isEmpty) {
      patientsList.value = allPatientsList;
    } else {
      final q = query.toLowerCase();
      patientsList.value = allPatientsList.where((patient) {
        final nameMatch = (patient.name ?? '').toLowerCase().contains(q);
        final phoneMatch = (patient.phoneNumber ?? '').contains(query);
        return nameMatch || phoneMatch;
      }).toList();
    }
  }

  void updateSelectedPatientStatus(String value) {
    selectedPatientStatus.value = value;
    final status = statusWithIds.firstWhere(
            (status) => status.label == value,
        orElse: () => PatientStatus(id: "", label: ''));
    selectedStatusId.value = status.id!;
  }

  void updateSelectedStatusId(String id) {
    selectedStatusId.value = id;
  }


  Future<void> getPatientStatus() async {
    try {
      isLoading.value = true;
      final response = await patientRepository.getPatientStatus();
      if (response.status != null) {
        statusWithIds.value = response.status!;
        statusList.value = response.status!.map((e) => e.label!).toList();
      }
    } catch (e) {
      errorMessage.value = 'Failed to fetch patient status';
      print('Error fetching patient status: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getPatients() async {
    try {
      isLoading.value = true;
      final response = await patientRepository.getPatients();
      patientResponse.value = response;
      if (response.leads != null) {
        patientsList.value = response.leads!;
        allPatientsList.value= response.leads!;
      }
    } catch (e) {
      errorMessage.value = 'Failed to fetch patients';
      print('Error fetching patients: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getSinglePatient(int id) async {
    try {
      isLoading.value = true;
      final response = await patientRepository.getSinglePatient(id);
      if (response != null) {
        leadDetails.value = response;
        // Initialize selected status with current patient status
        if (leadDetails.value.lead?.status?.id != null) {
          selectedStatusId.value = leadDetails.value.lead!.status!.id!;
        }
      }
      print("Single patient response: ${response.toJson()}");
    } catch (e) {
      errorMessage.value = 'Failed to fetch patient';
      print('Error fetching patient: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updatePatient({
    required int id,
    required String? status,
    required String? note,
  }) async {
    try {
      print("Updating patient with ID: $id");
      print("Status: $status");
      print("Note: $note");
      Map<String, dynamic> data = {
        "status": status,
        "note": note,
      };
      isLoading.value = true;
      final success = await patientRepository.updatePatient(
        id,
        data
      );

      if (success['message']=="Lead status updated successfully") {
        await getSinglePatient(id); // Refresh list if needed
        await getPatients(); // Refresh list if needed

      } else {

      }
    } catch (e) {
      print("Exception in updatePatient: $e");
      Get.snackbar('Error', 'Something went wrong');
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> refreshPatients() async {
    patientsList.clear();
    await getPatients();
  }


}