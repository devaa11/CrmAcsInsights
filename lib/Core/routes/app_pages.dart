
import 'package:get/get.dart';

import '../../Features/Contacts/ContactScreen.dart';
import '../../Features/CreatePatient/allleadScreen.dart';
import '../../Features/CreatePatient/createLeadScreen.dart';
import '../../Features/CreatePatient/leadDetailsScreen.dart';
import '../../Features/Home/Home_screen.dart';
import '../../Features/Login/ForgetScreen.dart';
import '../../Features/Login/LoginScreen.dart';
import '../../Features/Profile/ProfileScreen.dart';
import '../../Features/Settings/settingScreen.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.login,
      page: () => LoginScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.forgotScreen,
      page: () => ForgotPassWordScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.home,
      page: () => HomeScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.createPatient,
      page: () => CreatePatientScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.allPatient,
      page: () => Allpatientscreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.contactsScreen,
      page: () => Contactscreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.patientDetails,
      page: () => PatientDetailsScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.profile,
      page: () => ProfileScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),

    GetPage(
      name: Routes.setting,
      page: () => Settingscreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),

  ];
}
