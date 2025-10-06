import 'package:flutter/material.dart';
  import 'package:flutter/services.dart';
  import 'package:get/get.dart';
  import 'themeService.dart';

  class ThemeController extends GetxController {
    final ThemeService _themeService;
    RxBool isDarkMode = false.obs;

    ThemeController(this._themeService);

    void toggleTheme() {
      isDarkMode.value = !isDarkMode.value;
      Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
      // _updateStatusBarTheme();
      _themeService.saveTheme(isDarkMode.value);
    }

    void setInitialTheme(bool isDark) {
      isDarkMode.value = isDark;
      Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
      // _updateStatusBarTheme();
    }

    // void _updateStatusBarTheme() {
    //   SystemChrome.setSystemUIOverlayStyle(
    //     SystemUiOverlayStyle(
    //       statusBarColor: Colors.transparent,
    //       // Light theme: Black status bar icons
    //       // Dark theme: White status bar icons
    //       statusBarIconBrightness: isDarkMode.value ? Brightness.light : Brightness.dark,
    //       // Light theme: Light status bar background
    //       // Dark theme: Dark status bar background
    //       statusBarBrightness: isDarkMode.value ? Brightness.dark : Brightness.light,
    //     ),
    //   );
    // }
  }