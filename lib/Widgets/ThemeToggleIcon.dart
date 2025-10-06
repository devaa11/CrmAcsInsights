import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../Core/theme/themeController.dart';

class ThemeToggleIcon extends StatelessWidget {
  final ThemeController controller = Get.find();

  ThemeToggleIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return IconButton(
        icon: Icon(
          controller.isDarkMode.value ?  Icons.light_mode_outlined : Icons.dark_mode_outlined,
          size: 28.sp,
        ),
        onPressed: controller.toggleTheme,
        tooltip: controller.isDarkMode.value
            ? 'Switch to Light Mode'
            : 'Switch to Dark Mode',
      );
    });
  }
}
