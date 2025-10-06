import 'package:crmacsinsights/Features/Login/DataSource/login_datasource.dart';
import 'package:crmacsinsights/Features/Login/Model/LoginResponseModel.dart';


class Loginrepository {
  final LoginRemoteDataSource loginRemoteDataSource=LoginRemoteDataSource();


  Future<LoginResponseModel> login(String email, String password) {
    return loginRemoteDataSource.login(email, password);
  }

  Future<void> logout() {
    return loginRemoteDataSource.logout();
  }

  Future<dynamic> forgetPassword(String email) {
    return loginRemoteDataSource.forgetPassword(email);
  }


}
