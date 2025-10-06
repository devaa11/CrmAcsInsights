
import 'package:dio/dio.dart' as dio;

import '../Constants/ApiEndpoints.dart';
import '../storage/storage_service.dart';
import 'injection_container.dart';

class DioClient {
  final dio.Dio _dio = getDio();
  static const String baseUrl = ApiEndpoints.baseUrl;
  StorageService storageService = StorageService();

  DioClient() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    // _setupInterceptors();
  }

  // void _setupInterceptors() {
  //   _dio.interceptors.add(dio.InterceptorsWrapper(
  //     onRequest: (options, handler) async {
  //       options.headers.addAll(await _getHeaders());
  //       print("API Request: ${options.method} ${options.path}");
  //       return handler.next(options);
  //     },
  //
  //     onResponse: (response, handler) {
  //       return handler.next(response);
  //     },
  //     // onError: (dio.DioException e, handler) {
  //     //   final statusCode = e.response?.statusCode;
  //     //   final path = e.requestOptions.path;
  //     //
  //     //   print("API Error: $statusCode ${e.response?.data}");
  //     //
  //     //   // Skip auto-navigation if error is from login API (so controller can handle errors)
  //     //   if (statusCode == 401 || statusCode == 403 || statusCode == 404) {
  //     //     if (path.contains('/login')) {
  //     //       // Just forward error, don't navigate
  //     //       return handler.next(e);
  //     //     }
  //     //
  //     //     // For all other APIs, do auto-logout and redirect
  //     //     print("Unauthorized request - logging out");
  //     //     storageService.removeToken();
  //     //     Get.offAllNamed(Routes.login);
  //     //   }
  //     //
  //     //   return handler.next(e);
  //     // },
  //   ));
  // }

  Future<dynamic> getRequest(String endpoint) async {
    try {
      dio.Response response = await _dio.get(endpoint,
        options: dio.Options(headers: await _getHeaders()),
      );
      return response.data;
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<dynamic> postRequest(String endpoint, dynamic data,
      {bool includeHeaders = true, Map<String, String>? customHeaders}) async {
    try {
      dio.Options options = dio.Options(
        headers: includeHeaders
            ? await _getHeaders()
            : customHeaders ?? {},
      );

      dio.Response response = await _dio.post(endpoint, data: data, options: options);
      return response.data;
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<dynamic> putRequest(String endpoint, dynamic data) async {
    try {
      dio.Response response = await _dio.put(endpoint, data: data);
      return response.data;
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<dynamic> deleteRequest(String endpoint) async {
    try {
      dio.Response response = await _dio.delete(endpoint);
      return response.data;
    } catch (e) {
      return _handleError(e);
    }
  }

 Future<Map<String, String>> _getHeaders() async {
    String? token = await storageService.getToken();
    print(token);
    return {
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  dynamic _handleError(dynamic error) {
    // Just return the error message, no Snackbar
    String errorMessage = "An unexpected error occurred.";
    if (error is dio.DioException) {
      if (error.response != null) {
        errorMessage = error.response?.data["message"] ?? errorMessage;
      }
    }
    return {"error": true, "message": errorMessage}; // You can parse this in Controller/UI
  }
}
