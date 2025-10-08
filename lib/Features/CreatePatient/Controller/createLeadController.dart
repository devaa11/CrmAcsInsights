import 'package:crmacsinsights/Core/routes/app_routes.dart';
import 'package:crmacsinsights/Features/CreatePatient/DataSource/LeadRemoteDataSource.dart';
import 'package:crmacsinsights/Features/CreatePatient/Model/CreateLeadResponseModel.dart';
import 'package:crmacsinsights/Features/CreatePatient/Model/SourceResponseModel.dart';
import 'package:crmacsinsights/Features/Profile/Controller/ProfileController.dart';
import 'package:get/get.dart';

import '../../../Core/Utils/validator.dart';
import '../Model/SymptonsModel.dart';
import '../Repositoy/CreateLeadRepository.dart';

class CreatePatientcontroller extends GetxController {
  final PatientRemoteDataSource employeeRemoteDataSource = PatientRemoteDataSource();
  final CreatePatientRepository createPatientRepository = CreatePatientRepository();
  ProfileController profileController=Get.put(ProfileController());
  // Source related variables
  RxString selectedSource = ''.obs;
  RxInt selectedSourceId = 0.obs;
  RxList<String> sourceList = <String>[].obs;
  RxList<SourceItem> sourcesWithIds = <SourceItem>[].obs;

  // Symptoms related variables
  RxList<SymptomItem> symptomsList = <SymptomItem>[].obs;
  RxList<int> selectedSymptomIds = <int>[].obs;

  RxBool isLoading = false.obs;
  RxString apiMessage = ''.obs;
  Rx<CreatePatientResponseModel?> responseModel = Rx<CreatePatientResponseModel?>(null);

// Existing fields...
  final RxString nameError = RxString('');
  final RxString phoneError = RxString('');
  final RxString ageError = RxString('');
  final RxString addressError = RxString('');
  final RxString sourceError = RxString('');
  final RxString symptomsError = RxString('');

  // Method to validate all fields
  bool validateFields({
    required String name,
    required String phone,
    required String address,
  }) {
    // Clear previous errors
    clearErrors();

    // Validate each field
    nameError.value = Validators.validateName(name) ?? '';
    phoneError.value = Validators.validatePhone(phone) ?? '';
    addressError.value = Validators.validateAddress(address) ?? '';

    // Source validation
    if (selectedSourceId.value == 0) {
      sourceError.value = 'Please select a source';
    }

    // Symptoms validation
    if (selectedSymptomIds.isEmpty) {
      symptomsError.value = 'Please select at least one Service';
    }

    // Return true if there are no errors
    return !hasErrors;
  }

  // Helper method to clear all errors
  void clearErrors() {
    nameError.value = '';
    phoneError.value = '';
    ageError.value = '';
    addressError.value = '';
    sourceError.value = '';
    symptomsError.value = '';
  }

  // Helper to check if there are any errors
  bool get hasErrors {
    return nameError.value.isNotEmpty ||
        phoneError.value.isNotEmpty ||
        ageError.value.isNotEmpty ||
        addressError.value.isNotEmpty ||
        sourceError.value.isNotEmpty ||
        symptomsError.value.isNotEmpty;
  }

  // Method to reset form
  void resetForm() {
    clearErrors();
    selectedSourceId.value = 0;
    selectedSymptomIds.clear();
  }
  @override
  void onInit() {
    super.onInit();
    fetchSourcesAndSymtoms();
  }

  void updateSelectedSource(String value) {
    selectedSource.value = value;
    // Find the source ID associated with this name
    final source = sourcesWithIds.firstWhere(
            (source) => source.name == value,
        orElse: () => SourceItem(id: 0, name: ''));
    selectedSourceId.value = source.id;
  }

  void updateSelectedSourceId(int id) {
    selectedSourceId.value = id;
    // Also update the string representation for backwards compatibility
    final source = sourcesWithIds.firstWhere(
            (source) => source.id == id,
        orElse: () => SourceItem(id: 0, name: ''));
    selectedSource.value = source.name;
  }

  void updateSelectedSymptoms(List<int> ids) {
    selectedSymptomIds.value = ids;
  }

  void removeSymptomById(int id) {
    List<int> updated = [...selectedSymptomIds];
    updated.remove(id);
    selectedSymptomIds.value = updated;
  }

  // For backward compatibility
  void removeSymptom(String value) {
    final symptom = symptomsList.firstWhere(
            (symptom) => symptom.name == value,
        orElse: () => SymptomItem(id: 0, name: ''));

    if (symptom.id != 0) {
      removeSymptomById(symptom.id);
    }
  }

  Future<void> fetchSourcesAndSymtoms() async {
    try {
      final sourceResponse = await createPatientRepository.getSource();
      final symptomsResponse = await createPatientRepository.getSymptons();

      // Process sources with their IDs
      sourceList.value = sourceResponse.sources!.map((source) => source.name!).toList();

      sourcesWithIds.value = sourceResponse.sources!
          .map((source) => SourceItem(id: source.id!, name: source.name!))
          .toList();

      // Process symptoms with their IDs
      symptomsList.value = symptomsResponse.symptons!
          .map((symptom) => SymptomItem(id: symptom.id!, name: symptom.name!))
          .toList();
    } catch (e) {
      sourceList.value = [];
      print('Error fetching sources or symptoms: $e');
    }
  }

  Future<void> createSymptom(String name) async {
    try {
      isLoading.value = true;
      apiMessage.value = '';

      final result = await createPatientRepository.createSymtoms(name);
      apiMessage.value = result['message'] ?? 'Symptom created successfully';
      symptomsList.value= result['symptoms'] ?? [];
        } catch (e) {
      apiMessage.value = 'Failed to create symptom';
      print('Create Symptom Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> refreshSymtomsList() async {
    symptomsList.clear();
    await fetchSourcesAndSymtoms();
  }

  Future<void> createNewPatient({
    required String name,
    required String phone,
    required String age,
    required String address,
    required int source,
    required List<int> symptoms,
  }) async {
    isLoading.value = true;
    apiMessage.value = '';

    try {
      // Convert age to integer
      final ageInt = int.tryParse(age) ?? 0;

      // Prepare request data in required format
      Map<String, dynamic> data = {
        'name': name,
        'phone_number': phone,  // Changed from phone_no to phone_number
        'location': address,    // Changed from address to location
        'age': ageInt,         // Send as integer
        'source_id': source,   // Already an integer
        'symptoms': symptoms,   // Already List<int>
      };

      final result = await createPatientRepository.createPatient(data);
      responseModel.value = result;

      if (result.message != "Lead already exists") {
        apiMessage.value = result.message!;
        await profileController.getPieChartData();
        update();

        Get.toNamed(Routes.patientDetails,arguments: {
          "id": result.patient!.id,
        });

      }else{
        apiMessage.value = result.message!;


      }
    } catch (e) {
      apiMessage.value = 'Failed to create patient';
      print('Create Patient Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

}