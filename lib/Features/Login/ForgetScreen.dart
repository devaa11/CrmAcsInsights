import 'package:crmacsinsights/Widgets/app_textFields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../Core/Utils/validator.dart';
import '../../Core/theme/themeController.dart';
import '../../Core/theme/themeService.dart';
import '../../Widgets/app_Buttons.dart';
import 'Controller/LoginController.dart';

class ForgotPassWordScreen extends StatelessWidget {
  ForgotPassWordScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LoginController loginController = Get.put(LoginController());

  final TextEditingController _emailController = TextEditingController();
  final ThemeController themeController =
      Get.put(ThemeController(ThemeService()));

  @override
  Widget build(BuildContext context) {
    final isDark = themeController.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() {
                    return isDark.value ?
                    SvgPicture.asset(
                      "assets/Icons/acslogo.svg", height: 100,) :
                    SvgPicture.asset(
                      "assets/Icons/acslogo_light.svg", height: 100,);
                  }),
                  const Text(
                    'Enter your email address to reset your password',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  AuthField(
                    validator: Validators.validateEmail,
                    controller: _emailController,
                    hintText: 'Enter Email',
                  ),
                  SizedBox(height: 20.h),
                  PrimaryButton(
                    height: 55.h,
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        await loginController.forgetPassword(
                           _emailController.text,
                        );
                      }
                    },
                    text: 'Login',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
