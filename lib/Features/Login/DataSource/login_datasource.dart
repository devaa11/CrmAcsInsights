import 'package:dio/dio.dart';
import 'package:crmacsinsights/Core/Constants/ApiEndpoints.dart';
import 'package:crmacsinsights/Features/Login/Model/LoginResponseModel.dart';
import '../../../core/network/dio_client.dart';

class LoginRemoteDataSource {
  DioClient dioClient = DioClient();

  Future<LoginResponseModel> login(String email, String password) async {
    final response = await dioClient.postRequest(ApiEndpoints.login, {
      'email': email,
      'password': password,
    });
    if (response is Map<String, dynamic>) {
      return LoginResponseModel.fromJson(response);
    } else {
      throw Exception('Unexpected response format');
    }  }

  Future<void> logout() async {
   final response= await dioClient.postRequest(ApiEndpoints.logout, {});
    return response;
  }

  Future<dynamic> forgetPassword(String email) async {
    final response = await dioClient.postRequest(ApiEndpoints.forgotPassword, {
      'email': email,
    });
    return response;
  }


}