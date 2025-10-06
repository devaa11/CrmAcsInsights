import 'package:crmacsinsights/Features/Home/DataSource/home_datasource.dart';

class HomeRepository {
final HomeRemoteDataSource remoteDataSource=HomeRemoteDataSource();

  Future<Map<String, dynamic>> getHomeData()async {
    return remoteDataSource.getHomeData();
  }

}