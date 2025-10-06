import 'dart:io';

import 'package:crmacsinsights/Features/Profile/Model/ProfileResponseModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Core/Service/Permission_Service.dart';
import '../../../Core/Utils/common.dart';
import '../Repositoy/profileRepository.dart';

class ProfileController extends GetxController {
  final ProfileRepository profileRepository = ProfileRepository();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Rx<ProfileResponseModel> profileData = ProfileResponseModel().obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  var isEditing = false.obs;

  var totalLeads = 0.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var name = ''.obs;
  var phoneNo = ''.obs;
  var email = ''.obs;
  var imageUrl = ''.obs;

  Rxn<PieChartData> pieChartData = Rxn<PieChartData>();

  @override
  void onInit() {
    super.onInit();
    getProfile(); // Don't access profileData.value.user here
  }
  final ImagePicker _picker = ImagePicker();
  var pickedImage = Rxn<File>();

  Future<void> pickImage(BuildContext context) async {
    final hasPermission = await PermissionService.requestGalleryPermission();

    if (!hasPermission) {
      showAppSnackBar(context, 'Please allow access to gallery');
      return;
    }

    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        pickedImage.value = File(image.path);
        showAppSnackBar(context, 'Image selected successfully');
      }
    } catch (e) {
      showAppSnackBar(context, 'Failed to pick image');
    }
  }

  Future<void> getProfile() async {
    try {
      isLoading(true);
      var data = await profileRepository.getProfile();

      profileData.value = data;

      // Safe null checks before accessing properties
      name.value = data.user?.name ?? '';
      phoneNo.value = data.user?.phoneNo ?? '';
      email.value = data.user?.email ?? '';
      imageUrl.value = data.user?.imageUrl ?? '';

      // Initialize controllers with safe values
      nameController.text = name.value;
      phoneNoController.text = phoneNo.value;
      pieChartData.value= data.user?.pieChartData;
      totalLeads.value=data.user?.totalLeads ?? 0;

    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }

  Future<void>getPieChartData() async {
    try {
      isLoading(true);
      var data = await profileRepository.getProfile();
      pieChartData.value = data.user!.pieChartData;
      totalLeads.value = data.user!.totalLeads ?? 0;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }
  void refreshProfile() {
    getProfile();
    getPieChartData();
  }
void toggleEdit() async {
    if (isEditing.value) {
      name.value = nameController.text;
      phoneNo.value = phoneNoController.text;

      await updateProfile(imageFile: pickedImage.value);
      isEditing.value = false; // Ensure edit mode is turned off after update
    } else {
      nameController.text = name.value;
      phoneNoController.text = phoneNo.value;
      isEditing.value = true;
    }
  }

  Future<void> updateProfile({File? imageFile}) async {
    try {
      isLoading(true);
      await profileRepository.updateProfile(
        name: nameController.text,
        phoneNo: phoneNoController.text,
        imageFile: imageFile,
        password: passwordController.text
      );

      isEditing(false);
      await getProfile();

      Get.snackbar('Success', 'Profile updated successfully',backgroundColor: Colors.green,colorText: Colors.white);
    } catch (e) {
      Get.snackbar('Error', "Profile Not updated successfully",backgroundColor: Colors.red,colorText: Colors.white);
    } finally {
      isLoading(false);
    }
  }


  @override
  void onClose() {
    nameController.dispose();
    phoneNoController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
