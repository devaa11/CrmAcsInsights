import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;  // Hide Get's Response class

import '../Utils/common.dart';
import '../routes/app_routes.dart';
import '../storage/storage_service.dart';

Dio getDio() {
  Dio dio = Dio();

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (RequestOptions options, handler) async {
        // Print API details
        print("📤 API Request:");
        print("URL: ${options.baseUrl}${options.path}");
        print("Headers: ${options.headers}");
        print("Request Body: ${options.data}");
        return handler.next(options);
      },
      onResponse: (Response response, handler) {
        print("✅ API Response: ${response.statusCode} ${response.data}");
        return handler.next(response);
      },
onError: (DioException e, handler) {
          print("Status Code: ${e.response?.statusCode??""}");
          print("Error Data:  ${e.response?.data??""}");


          if(e.response?.statusCode == 401) {
            StorageService().removeToken();

            // Handle 401 Unauthorized error
            print("Unauthorized request. Please log in again.");
            // Navigate to login screen
            Get.offAllNamed(Routes.login);
         } else if (e.response?.statusCode == 500) {

              print("Internal server error. Please try again later.");
              showAppSnackBar(Get.context!, "Internal server error. Yor are logging out shortly");
              Future.delayed(const Duration(seconds: 10), () {
                StorageService().removeToken();
                Get.offAllNamed(Routes.login);
              });
          } else if (e.response?.statusCode == 400) {
            StorageService().removeToken();

            // Handle 400 Bad Request
            print("Bad request. Please check your input.");
            Get.offAllNamed(Routes.login);

          } else if(e.response?.statusCode == 404){
            StorageService().removeToken();

            // Handle 404 Not Found
            print("Resource not found. Please check the URL.");
            Get.offAllNamed(Routes.login);

          } else if (e.response?.statusCode == 403) {
            StorageService().removeToken();

            // Handle 403 Forbidden
            print("Access forbidden. You do not have permission to access this resource.");
            Get.offAllNamed(Routes.login);

          } else if (e.response?.statusCode == 408) {
            StorageService().removeToken();

            // Handle 408 Request Timeout
            print("Request timeout. Please try again later.");
            Get.offAllNamed(Routes.login);

          } else if (e.response?.statusCode == 429) {
            StorageService().removeToken();

            // Handle 429 Too Many Requests
            print("Too many requests. Please slow down.");
            Get.offAllNamed(Routes.login);


          }
          else {
            // Handle other errors
            print("Error: ${e.message}");
          }
          //we can navigate use on another status code
          return handler.next(e);
        },
      ),
  );

  return dio;
}