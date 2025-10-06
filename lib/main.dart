import 'package:crmacsinsights/Core/Service/Permission_Service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'Core/routes/app_pages.dart';
import 'Core/theme/app_theme.dart';
import 'Core/theme/themeController.dart';
import 'Core/theme/themeService.dart';
import 'Features/Splash/splashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeService = ThemeService();
  final isDark = await themeService.loadTheme();
  final themeController = Get.put(ThemeController(themeService)); // Pass service to controller
  PermissionService.requestAllPermissions();
  themeController.setInitialTheme(isDark);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (__,child){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'CRM ACS Insights',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
          home: Splashscreen(),
          getPages: AppPages.routes,
        );
      },
    );
  }
}
