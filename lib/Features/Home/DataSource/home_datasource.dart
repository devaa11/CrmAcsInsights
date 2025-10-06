import 'package:crmacsinsights/Core/Constants/ApiEndpoints.dart';

import '../../../Core/network/dio_client.dart';

class HomeRemoteDataSource {
  DioClient dioClient=DioClient();

  Future<Map<String, dynamic>> getHomeData() async {
    final response = await dioClient.getRequest(ApiEndpoints.home);
    return response.data;
  }
}