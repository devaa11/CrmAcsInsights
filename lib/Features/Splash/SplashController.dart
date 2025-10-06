import 'package:crmacsinsights/Core/storage/storage_service.dart';
import 'package:get/get.dart';

class SplashController extends GetxController{
  final StorageService storageService=StorageService();
  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 2), () {
      navigationPage();


    });
  }

  Future<void>navigationPage() async {
    final isAvailable = await isLoggedIn();
    if(isAvailable) {
      Get.offAllNamed('/home');
    } else {
      Get.offAllNamed('/login');
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await storageService.getToken();
    if(token != null && token.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}