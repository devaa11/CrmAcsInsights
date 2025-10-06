import 'package:dio/dio.dart';
import 'package:crmacsinsights/Core/Utils/common.dart';
import 'package:crmacsinsights/Core/routes/app_routes.dart';
import 'package:crmacsinsights/Core/storage/storage_service.dart';
import 'package:crmacsinsights/Features/Login/repository/LoginRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final Loginrepository repo = Loginrepository();
  final StorageService storageService = StorageService();
  var isLoading = false.obs;
  var loginError = ''.obs; // <-- Add this

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    loginError.value = '';
    try {
      final data = await repo.login(email, password);

      if (data.tokenType != null) {
        await storageService.saveToken(data.accessToken);
        await Get.offAllNamed(Routes.home);
      }

      else if (data.message != null) {
        loginError.value = data.message!;
        Get.snackbar('Error', data.message!,
            colorText: Colors.white, backgroundColor: Colors.red);
      } else {
        loginError.value = 'Invalid email or password';
        Get.snackbar('Error', 'Invalid email or password',
            colorText: Colors.white, backgroundColor: Colors.red);
      }
    } on DioException catch (e) {
      final response = e.response;
      if (response != null && response.data != null) {
        final errorMessage = response.data['message'] ?? 'Login failed';
        loginError.value = errorMessage;
        Get.snackbar('Login Failed', errorMessage,
            colorText: Colors.white, backgroundColor: Colors.red);
      } else {
        loginError.value = 'Something went wrong';
        Get.snackbar('Login Failed', 'Something went wrong',
            colorText: Colors.white, backgroundColor: Colors.red);
      }
    } catch (e) {
      print("Login Error: $e");
      loginError.value = 'Unexpected error occurred';
      Get.snackbar('Login Failed', 'Unexpected error occurred',
          colorText: Colors.white, backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      isLoading.value = true;
      await repo.logout();
      await storageService.removeToken();
      Get.offAllNamed(Routes.login);
    } catch (e) {
      print("Logout Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> forgetPassword(String email) async {
    try {
      isLoading.value = true;
      loginError.value = ''; // Clear any previous error

      final response = await repo.forgetPassword(email);
      final message = response['message'];
      if (message != null) {
        if (message == 'Password reset link sent to your email') {
          Get.snackbar('Success', message,colorText: Colors.white,
            backgroundColor: Colors.green);
          Get.offNamed(Routes.login);
        } else {
          Get.snackbar('Error', message,colorText: Colors.white,
            backgroundColor: Colors.red);
        }
      } else {
        Get.snackbar('Error', 'Failed to send reset link',colorText: Colors.white,
          backgroundColor: Colors.red);
      }

    } catch (e, stacktrace) {
      debugPrint("Forget Password Error: $e\n$stacktrace");
      loginError.value = 'Failed to send reset link';

    } finally {
      isLoading.value = false;
    }
  }

}
