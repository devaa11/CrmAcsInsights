import 'package:crmacsinsights/Core/Constants/ApiEndpoints.dart';
import 'package:crmacsinsights/Core/network/dio_client.dart';
import 'package:crmacsinsights/Features/CreatePatient/Model/CreateLeadResponseModel.dart';
import 'package:crmacsinsights/Features/CreatePatient/Model/LeadStatusResponseModel.dart';
import 'package:crmacsinsights/Features/CreatePatient/Model/SingleLeadResponseModel.dart';
import 'package:crmacsinsights/Features/CreatePatient/Model/SourceResponseModel.dart';
import 'package:crmacsinsights/Features/CreatePatient/Model/SymptonsModel.dart';
import 'package:crmacsinsights/Features/CreatePatient/Model/leadsResponseModel.dart';

class PatientRemoteDataSource {

  final DioClient dioClient=DioClient();

  Future<SourceResponseModel> getSources() async {
    try {
      final response = await dioClient.getRequest(ApiEndpoints.sources);
      return SourceResponseModel.fromJson(response);
    } catch (e) {
      print('Error in data source: $e');
      throw Exception('Failed to fetch sources');
    }
  }

  Future<SymptomsModel> getSymptons() async {
    try {
      final response = await dioClient.getRequest(ApiEndpoints.symtoms);
      return SymptomsModel.fromJson(response);
    } catch (e) {
      print('Error in data source: $e');
      throw Exception('Failed to fetch sources');
    }
  }

  Future<dynamic>createSymtoms(String name) async {
    try {
      final response = await dioClient.postRequest(ApiEndpoints.createSymptom, {
        'name': name,
      });
      return response;
    } catch (e) {
      print('Error in creating symtoms: $e');
      throw Exception('Failed to fetch symtoms');
    }
  }

  Future<CreatePatientResponseModel> createPatient(Map<String, dynamic> data) async {
    try{
      final response = await dioClient.postRequest(ApiEndpoints.createPatient, data);
      return CreatePatientResponseModel.fromJson(response);
    }catch(e){
      print('Error in data source: $e');
      throw Exception('Failed to create leadsss');
    }
  }

  Future<LeadsResponseModel> getPatients() async {
    try{
      final response = await dioClient.getRequest(ApiEndpoints.getPatient);
      return LeadsResponseModel.fromJson(response);
    }catch(e){
      print('Error in data source: $e');
      throw Exception('Failed to fetch leadss');
    }
  }

Future<SinglePatientResponseModel> getSinglePatient(int id) async {
  try{
    final response = await dioClient.postRequest(ApiEndpoints.getSinglePatient(id),{});
    return SinglePatientResponseModel.fromJson(response);
  }catch(e){
    print('Error in data source: $e');
    throw Exception('Failed to fetch leads');
  }


}

Future<dynamic> updatePatientStatus(int id,Map<String, dynamic> data)async{
  try{
    final response = await dioClient.postRequest(ApiEndpoints.updatePatientStatus(id),data);
    return response;
  }catch(e){
    print('Error in data source: $e');
    throw Exception('Failed to fetch patients');
  }
}

Future<PatientStatusResponseModel> getPatientStatus() async {
  try{
    final response = await dioClient.getRequest(ApiEndpoints.getPatientStatus);
    return PatientStatusResponseModel.fromJson(response);
  }catch(e){
    print('Error in data source: $e');
    throw Exception('Failed to fetch patients');
  }
}




}