import 'dart:io';
import 'package:dio/dio.dart';
import 'package:crmacsinsights/Core/Constants/ApiEndpoints.dart';
import 'package:crmacsinsights/Core/network/dio_client.dart';
import 'package:crmacsinsights/Features/Profile/Model/ProfileResponseModel.dart';

class ProfileDataSource {
  final DioClient client = DioClient();

  Future<ProfileResponseModel> getProfile() async {
    final response = await client.getRequest(ApiEndpoints.getUserProfile);
    return ProfileResponseModel.fromJson(response);
  }

  Future<void> updateProfile({
    required String name,
    required String phoneNo,
    File? imageFile, // Optional
    String? password,
  }) async {
    final formData = FormData.fromMap({
      'name': name,
      'phone_number': phoneNo,
      'password': password,
      if (imageFile != null)
        'image': await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
    });

    final response = await client.postRequest(
      ApiEndpoints.updateProfile,
      formData,
      customHeaders: {
        'Content-Type': 'multipart/form-data',
      },
    );

    if (response == null || response['message'] != "Profile updated successfully.") {
      throw Exception("Failed to update profile");
    }
  }
}
