import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF1e489f);
  static const Color primaryDark = Color(0xFF163872);
  static const Color primaryDarker = Color(0xFF1E1466);

  static const Color secondaryColorLight = Color(0xff5bac46);

  //Shadow Colors
  static const Color shadowLight = Color(0xFF90D1CA);
  static const Color shadowDark = Color(0xFF6E6E6E);

  //Card Color
  static const Color cardColor = Color(0xFFFFFFFF);
  static const Color cardColorDark = Color(0xFF181D23);

  // Text Field border Color
  static Color textFieldEnabledBorderColor = Colors.grey.shade400;
  static Color textFieldEnabledBorderColorDark = Colors.grey.shade400;
  static const Color textFieldFocusedBorderColor = Color(0xFF5D5BFC);
  static const Color textFieldFocusedBorderColorDark = Color(0xFF3F28D2);
  static const Color textFieldErrorBorderColor = Color(0xFFFF133F);
  static const Color textFieldErrorBorderColorDark = Color(0xFFB00020);

  // Background & Surface
  static const Color backgroundLight = Color(0xFFF5F6FC);
  static const Color backgroundDark = Color(0xFF1A2227);
  static const Color surface = Colors.white;

  //Icons Colors
  static const Color iconColorLight = Color(0xFF000000);
  static const Color iconColorDark = Color(0xFFFFFFFF);

  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF212121);
  static const Color subTextPrimary = Color(0xFF9D9D9D);

  // Error Color
  static const Color error = Colors.red;

  // Shades (optional for use in gradients or button states)
  static const List<Color> primaryShades = [
    Color(0xFF90D1CA),
    Color(0xFF6DC5BD),
    Color(0xFF4AB9AF),
    Color(0xFF129990),
    Color(0xFF096B68),
  ];

  static const Color newCall = Color(0xFF1976D2); // Blue - New Call
  static const Color ringNoResponse = Color(0xFFFFC107); // Amber - Ring No Response
  static const Color followUp = Color(0xFF673AB7); // Deep Purple - Follow Up
  static const Color interested = Color(0xFF388E3C); // Green - Interested
  static const Color notInterested = Color(0xFF9E9E9E); // Grey - Not Interested
  static const Color escalatedToDoctor = Color(0xFFD32F2F); // Red - Escalated to Doctor
  static const Color review = Color(0xFF00897B); // Teal - Review
  static const Color postOpFollowUp = Color(0xFF3F51B5);
}
