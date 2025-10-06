class ApiEndpoints {
  // Base URL (Optional if set in Dio)
  // static const String baseUrl = "https://app.drdictins.com/api";
  static const String baseUrl = "https://crm.acsinsights.com/api";

  // Auth
  static const String login = "/login";
  static const String logout = "/logout";
  static const String forgotPassword = "/forgot-password";

  //Home
  static const String home = "/home";

  // Patient
  static const String createPatient = "/lead/create";
  static const String getPatient = "/leads";
  static const String sources = "/sources";
  static const String symtoms = "/symptoms";
  static String getSinglePatient(int id) => "/lead/$id";
  static String updatePatientStatus(int id) => "/lead/$id/update";
  static const String getPatientStatus = "/lead/status";
  static const String createSymptom = "/symptom/create";

  // Profile
  static const String getUserProfile = "/profile";
  static const String updateProfile = "/profile/update";

// Add more modules as needed...
}
