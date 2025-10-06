
import 'package:crmacsinsights/Features/CreatePatient/DataSource/LeadRemoteDataSource.dart';
import 'package:crmacsinsights/Features/CreatePatient/Model/CreateLeadResponseModel.dart';
import 'package:crmacsinsights/Features/CreatePatient/Model/SourceResponseModel.dart';
import 'package:crmacsinsights/Features/CreatePatient/Model/SymptonsModel.dart';

class CreatePatientRepository {
  final PatientRemoteDataSource patientRemoteDataSource = PatientRemoteDataSource();

  Future<SourceResponseModel> getSource() async{
    return patientRemoteDataSource.getSources();
  }

  Future<SymptomsModel> getSymptons() async{
    return patientRemoteDataSource.getSymptons();
  }

  Future<CreatePatientResponseModel> createPatient(Map<String, dynamic> data) async {
    return patientRemoteDataSource.createPatient(data);
  }

  Future<dynamic> createSymtoms(String name) async {
    return patientRemoteDataSource.createSymtoms(name);
  }

}