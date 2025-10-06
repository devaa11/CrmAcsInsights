import 'package:crmacsinsights/Widgets/WebViewPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../Core/theme/themeController.dart';
import '../../Widgets/PrimaryContainer.dart';

class Settingscreen extends StatelessWidget {
  const Settingscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Appearance',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 12.h),
              Obx(() => PrimaryContainer(
                    child: ListTile(
                      leading: Icon(
                        themeController.isDarkMode.value
                            ? Icons.dark_mode
                            : Icons.light_mode,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: Text(
                        'Dark Mode',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Switch(
                        value: themeController.isDarkMode.value,
                        onChanged: (value) => themeController.toggleTheme(),
                        activeColor: Theme.of(context).primaryColor,
                      ),
                    ),
                  )),
              SizedBox(height: 24.h),
              Text(
                'About',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 12.h),
              SettingTile(
                icon: Icons.file_copy_outlined,
                title: 'Terms and Conditions',
                onTap: () {
                  Get.to(WebViewPage(), arguments: {
                    'url': 'https://www.drdictins.com/about',
                    'title': 'Terms and Conditions',
                  });
                },
              ),
              SizedBox(height: 12.h),
              SettingTile(
                icon: Icons.description_outlined,
                title: 'Privacy Policy',
                onTap: () {
                  Get.to(WebViewPage(), arguments: {
                    'url': 'https://www.drdictins.com/privacy',
                    'title': 'Privacy Policy',
                  });
                },
              ),
              SizedBox(height: 12.h),
              SettingTile(
                icon: Icons.info_outline,
                title: 'About Us',
                onTap: () {
                  Get.to(WebViewPage(), arguments: {
                    'url': 'https://www.drdictins.com/about',
                    'title': 'About Us',
                  });
                },
              ),
              SizedBox(height: 12.h),
              SettingTile(
                icon: Icons.support_agent_outlined,
                title: 'Contact Us',
                onTap: () {
                  Get.to(WebViewPage(), arguments: {
                    'url': 'https://www.drdictins.com/contact-3',
                    'title': 'Contact Us',
                  });
                },
              ),
              SizedBox(height: 12.h),
              PrimaryContainer(
                child: ListTile(
                  leading: Icon(
                    Icons.info_outline,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(
                    'App Version',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: Text(
                    '1.0.2',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingTile extends StatelessWidget {
  SettingTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });
  IconData icon;
  String title;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          leading: Icon(
            icon,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
