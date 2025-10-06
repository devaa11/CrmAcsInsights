import 'dart:io';

import 'package:crmacsinsights/Features/Profile/DataSource/profileDataSource.dart';
import 'package:crmacsinsights/Features/Profile/Model/ProfileResponseModel.dart';

class ProfileRepository {

  final ProfileDataSource profileDataSource=ProfileDataSource();

  Future<ProfileResponseModel> getProfile() async {
    return profileDataSource.getProfile();
  }

  Future<void> updateProfile({
    required String name,
    required String phoneNo,
    File? imageFile,
    String? password,
  }) {
    return profileDataSource.updateProfile(
      name: name,
      phoneNo: phoneNo,
      imageFile: imageFile,
      password: password
    );
  }
}