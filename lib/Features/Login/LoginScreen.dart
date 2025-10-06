import 'package:crmacsinsights/Core/Constants/text_styles.dart';
import 'package:crmacsinsights/Core/Utils/validator.dart';
import 'package:crmacsinsights/Core/routes/app_routes.dart';
import 'package:crmacsinsights/Core/theme/themeController.dart';
import 'package:crmacsinsights/Core/theme/themeService.dart';
import 'package:crmacsinsights/Features/Login/Controller/LoginController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../Widgets/app_Buttons.dart';
import '../../Widgets/app_textFields.dart';

class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController loginController = Get.put(LoginController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  final ThemeController themeController = Get.put(
      ThemeController(ThemeService()));

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }


  @override
  Widget build(BuildContext context) {


    final isDark = themeController.isDarkMode;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .scaffoldBackgroundColor,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                Obx(() {
                  return isDark.value ?
                  SvgPicture.asset(
                    "assets/Icons/acslogo.svg", height: 100,) :
                  SvgPicture.asset(
                    "assets/Icons/acslogo_light.svg", height: 100,);
                }),
                SizedBox(height: 20.h),
                Center(
                  child: Text(
                    'Welcome Back',
                    style: AppTextStyles.BiggerHeading,
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Text(
                    'Sign in to unlock exclusive features and personalized content',
                    style: AppTextStyles.SmallCaption,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 50),
                AuthField(
                  validator: Validators.validateEmail,
                  controller: _emailController,
                  hintText: 'Enter Email',
                ),
                const SizedBox(height: 30),
                AuthField(
                  validator: Validators.validatePassword,
                  controller: _passwordController,
                  hintText: 'Enter Password',
                  isPasswordField: true, // This will make it a password field with the eye toggle

                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomTextButton(
                    onPressed: () {
                      Get.toNamed(Routes.forgotScreen);
                    },
                    text: 'Forget Password?',
                  ),
                ),
                Obx(() {
                  if(loginController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return PrimaryButton(
                    height: 55.h,
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        await loginController.login(
                          _emailController.text.trim(),
                          _passwordController.text.trim(),
                        );
                      }
                    },
                    text: 'Login',
                  );
                }),
                SizedBox(height: 10.h),
                Obx(() {
                  return loginController.loginError.value.isNotEmpty
                      ? Text(
                    loginController.loginError.value,
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  )
                      : SizedBox.shrink();
                }),

              ],
            ),
          ),
        ),
      ),
    );
  }
}



