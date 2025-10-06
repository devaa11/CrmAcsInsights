import 'package:cached_network_image/cached_network_image.dart';
import 'package:crmacsinsights/Core/Constants/Colors.dart';
import 'package:crmacsinsights/Core/Constants/text_styles.dart';
import 'package:crmacsinsights/Core/routes/app_routes.dart';
import 'package:crmacsinsights/Features/Home/Components/LeadAnalyticsChart.dart';
import 'package:crmacsinsights/Features/Login/Controller/LoginController.dart';
import 'package:crmacsinsights/Features/Profile/Controller/ProfileController.dart';
import 'package:crmacsinsights/Widgets/PrimaryContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../Widgets/ThemeToggleIcon.dart';
import 'Components/ServiceButtons.dart';

class HomeScreen extends StatelessWidget {

  HomeScreen({super.key});

  final LoginController loginController = Get.put(LoginController());
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Add this to ensure status bar is visible with proper color
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Obx(() {
          if (profileController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
        
          // if (profileController.errorMessage.value.isNotEmpty) {
          //   return Center(
          //     child: Text(
          //       profileController.errorMessage.value,
          //       style: TextStyle(color: Colors.red, fontSize: 16.sp),
          //     ),
          //   );
          // }
          final user = profileController.profileData.value;
        
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
                  bottom: 30),
              child: Column(
                spacing: 20.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5.h),

                  //User Details And Notification
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Get.toNamed(Routes.profile);
                        },
                        child: Row(
                          children: [
                            ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: profileController.imageUrl.value.isNotEmpty == true
                                    ? profileController.imageUrl.value
                                    : ' ',
                                width: 60.r,
                                height: 60.r,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) =>
                                    Image.asset("assets/user.jpg",width: 120,height: 120,fit: BoxFit.cover,)

                              ),
                            ),

                            SizedBox(
                              width: 10.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text('Welcome back', style: AppTextStyles.caption),
                                SizedBox(
                                  width: 120.w,
                                  child: Text(
                                    user.user?.name ?? 'User',
                                    style: AppTextStyles.captionBold,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                SizedBox(
                                  width: 120.w,
                                  child: Text(
                                    user.user?.phoneNo ?? '',
                                    style: AppTextStyles.SmallCaption,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),

                              ],
                            )
                          ],
                        ),
                      ),
        
                      //Notification Icon
                      ThemeToggleIcon(),

                    ],
                  ),
        
                  //
        
                  PrimaryContainer(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Hi ${user.user?.name ?? "User"}!",
                style: AppTextStyles.heading2,
              ),
              SizedBox(height: 8.h),
              Text(
                "Ready for a productive day?",
                style: AppTextStyles.caption,
              ),
              SizedBox(height: 4.h),
              Text(
                "Here’s your daily business snapshot.",
                style: AppTextStyles.subText,
              ),
            ],
          ),
        ),
        
                  ServiceButton(
                    color: AppColors.secondaryColorLight,
                    text: "Create Leads",
                    textColor: Colors.white,
                    iconColor: Colors.white,
                    assetPath: "assets/Icons/add_patient.png",
                    onTap: () {
                      Get.toNamed(Routes.createPatient);
                    },
                  ),
        
                  ServiceButton(
                    text: "All Leads",
                    assetPath: "assets/Icons/group-users.png",
                    onTap: () {
                      Get.toNamed(Routes.allPatient);
                    },
                  ),

                  LeadAnalyticsChart(),
        
        
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
