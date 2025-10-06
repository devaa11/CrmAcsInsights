import 'package:cached_network_image/cached_network_image.dart';
import 'package:crmacsinsights/Core/Utils/validator.dart';
import 'package:crmacsinsights/Core/routes/app_routes.dart';
import 'package:crmacsinsights/Features/Login/Controller/LoginController.dart';
import 'package:crmacsinsights/Features/Profile/Controller/ProfileController.dart';
import 'package:crmacsinsights/Widgets/PrimaryContainer.dart';
import 'package:crmacsinsights/Widgets/app_Buttons.dart';
import 'package:crmacsinsights/Widgets/app_textFields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Core/Constants/Colors.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController profileController = Get.put(ProfileController());
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(height: 70.r),
            _buildProfileHeader(context),
            _buildMenuItems(context),
            SizedBox(
              height: 25.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              child: PrimaryButton(
                onTap: () async {
                  loginController.logout();

                },
                text: "Logout",
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Obx(() {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          // Main container
          PrimaryContainer(
            margin: EdgeInsets.all(16.w),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 700),
              width: double.infinity,
              padding: EdgeInsets.only(
                top: 60.r, // Padding for avatar overlap
                left: 16.w,
                right: 16.w,
                bottom: 16.w,
              ),
              child: Column(
                children: [
                  SizedBox(height: 8.h),
                  if (profileController.isEditing.value)
                    Form(
                      key: profileController.formKey,
                      child: Column(
                        children: [
                          _buildTextField(
                            profileController.nameController,
                            'Name',
                            validator: (value) => value == null || value.isEmpty
                                ? 'Name is required'
                                : null,
                          ),
                          SizedBox(height: 8.h),
                          _buildTextField(
                            profileController.phoneNoController,
                            'Phone No',
                            validator: Validators.validatePhone,
                          ),
                          SizedBox(height: 8.h),
                          _buildTextField(
                            profileController.passwordController,
                            'Password',
                            validator: (value) {
                              if (value == null) return null;
                              if (value.isNotEmpty && value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 8.h),
                          PrimaryButton(
                            text: "Update",
                            onTap: () {
                              if (profileController.formKey.currentState!
                                  .validate()) {
                                profileController.updateProfile();
                              }
                            },
                          ),
                        ],
                      ),
                    )
                  else
                    Column(
                      children: [
                        Text(
                          profileController.name.value,
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          profileController.phoneNo.value,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          // Positioned CircleAvatar (half out, half in)
          Positioned(
            top: -50.r, // Half of avatar radius to make it half out
            left: 0,
            right: 0,
            child: Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 60.r,
                    backgroundImage: profileController.pickedImage.value != null
                        ? FileImage(profileController.pickedImage.value!)
                        : null,
                    child: profileController.pickedImage.value == null
                        ? ClipOval(
                            child: CachedNetworkImage(
                              imageUrl:
                                  profileController.imageUrl.value.isNotEmpty ==
                                          true
                                      ? profileController.imageUrl.value
                                      : ' ',
                              width: 120.r,
                              height: 120.r,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) =>
                              Image.asset("assets/user.jpg",width: 120,height: 120,fit: BoxFit.cover,)

                            ),
                          )
                        : null,
                  ),
                  if (profileController.isEditing.value)
                    GestureDetector(
                      onTap: () => profileController.pickImage(context),
                      child: Container(
                        padding: EdgeInsets.all(6.w),
                        decoration: BoxDecoration(
                           color:  AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 16.w,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          // Edit button at top right corner of the container
// Remove the edit button at top right when editing
          if (!profileController.isEditing.value)
            Positioned(
              top: 8.w,
              right: 24.w,
              child: GestureDetector(
                onTap: profileController.toggleEdit,
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 18.w,
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      ),
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    return Column(
      children: [
        _buildMenuItem(context, Icons.settings_outlined, 'Setting', onTap: () {
          Get.toNamed(Routes.setting);
        }),
        // _buildMenuItem(context, Icons.help_outline, 'Help'),
      ],
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title,
      {VoidCallback? onTap}) {
    return PrimaryContainer(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          leading: Icon(
            icon,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16.w,
            color: Colors.grey,
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
