import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'colors.dart';

class AppTextStyles {
  static  TextStyle BiggerHeading = TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
  );


  static  TextStyle heading = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
  );

  static    TextStyle heading2 = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
  );

  static    TextStyle body = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
  );

  static TextStyle caption = TextStyle(
    fontSize: 14.sp,
  );

  static    TextStyle SmallCaptionBold = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.bold
  );
  static    TextStyle SmallCaption = TextStyle(
    fontSize: 14.sp,
  );

  static    TextStyle captionBold = TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.bold
  );


  static    TextStyle subText = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.subTextPrimary,
  );

  static    TextStyle button = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static  TextStyle  error = TextStyle(
    fontSize: 14.sp,
    color: AppColors.error,
  );

  static    TextStyle smallTextBold = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
}
