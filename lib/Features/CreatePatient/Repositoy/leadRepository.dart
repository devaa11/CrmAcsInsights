import 'package:crmacsinsights/Features/CreatePatient/DataSource/LeadRemoteDataSource.dart';
import 'package:crmacsinsights/Features/CreatePatient/Model/LeadStatusResponseModel.dart';
import 'package:crmacsinsights/Features/CreatePatient/Model/leadsResponseModel.dart';

import '../Model/SingleLeadResponseModel.dart';

class PatientRepository {
  final PatientRemoteDataSource patientRemoteDataSource = PatientRemoteDataSource();


  //get patients
  Future<LeadsResponseModel> getPatients() async {
    return patientRemoteDataSource.getPatients();
  }

  //get single patient
  Future<SinglePatientResponseModel> getSinglePatient(int id) async {
    return patientRemoteDataSource.getSinglePatient(id);
  }

  //update patient
  Future<dynamic> updatePatient(int id, Map<String, dynamic> data) async {
    return patientRemoteDataSource.updatePatientStatus(id, data);
  }

  //patient status
 Future<PatientStatusResponseModel> getPatientStatus() async {
    return patientRemoteDataSource.getPatientStatus();
  }





}