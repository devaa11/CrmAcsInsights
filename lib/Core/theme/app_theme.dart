import 'package:flutter/material.dart';
import '../Constants/text_styles.dart';
import '../constants/colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    cardColor: AppColors.cardColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.cardColor
    ),
    scaffoldBackgroundColor: AppColors.backgroundLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    // textTheme:  TextTheme(
    //
    //   bodyLarge:  AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
    //   bodySmall: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
    //   headlineLarge: AppTextStyles.heading.copyWith(color: AppColors.textSecondary),
    //   bodyMedium: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
    //   labelSmall: AppTextStyles.caption.copyWith(color: AppColors.subTextPrimary),
    // ),
    iconTheme:IconThemeData(color: AppColors.iconColorLight),
    // inputDecorationTheme: InputDecorationTheme(
    //   enabledBorder: OutlineInputBorder(
    //     borderSide: BorderSide(color: AppColors.textFieldEnabledBorderColor), // Your custom color
    //     borderRadius: BorderRadius.circular(8),
    //   ),
    //   focusedBorder: OutlineInputBorder(
    //     borderSide: BorderSide(color: AppColors.textFieldFocusedBorderColor, width: 2),
    //     borderRadius: BorderRadius.circular(8),
    //   ),
    //   errorBorder: OutlineInputBorder(
    //     borderSide: BorderSide(color: AppColors.textFieldErrorBorderColor),
    //     borderRadius: BorderRadius.circular(8),
    //   ),
    //   focusedErrorBorder: OutlineInputBorder(
    //     borderSide: BorderSide(color: AppColors.textFieldErrorBorderColor, width: 2),
    //     borderRadius: BorderRadius.circular(8),
    //   ),
    // ),


    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.primaryDark,
      background: AppColors.backgroundLight,
      error: AppColors.error,
      primaryContainer: AppColors.cardColor,
      secondaryContainer:  AppColors.cardColor


    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primaryDark,
    cardColor: AppColors.cardColorDark,

    cardTheme: CardThemeData(
      color: AppColors.cardColorDark
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    ),

    scaffoldBackgroundColor: AppColors.backgroundDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryDark,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    iconTheme:IconThemeData(color: AppColors.iconColorDark),
    // textTheme:  TextTheme(
    //
    //   bodyLarge:  AppTextStyles.caption.copyWith(color: AppColors.textPrimary),
    //   bodySmall: AppTextStyles.caption.copyWith(color: AppColors.textPrimary),
    //   headlineLarge: AppTextStyles.heading.copyWith(color: AppColors.textPrimary),
    //   bodyMedium: AppTextStyles.body.copyWith(color: AppColors.textPrimary),
    //   labelSmall: AppTextStyles.caption.copyWith(color: AppColors.subTextPrimary),
    // ),
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryDark,
      secondary: AppColors.primaryDarker,
      primaryContainer: AppColors.cardColorDark,
      error: AppColors.error,
    ),
  );


}
