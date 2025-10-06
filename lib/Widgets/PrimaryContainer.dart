import 'package:flutter/material.dart';

import '../Core/Constants/Colors.dart';

class PrimaryContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? width;
  final double? height;

  const PrimaryContainer({
    required this.child,
    this.padding,
    this.margin,
    this.width,
    this.height,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).cardTheme.color;

    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: colorScheme,
        boxShadow: [
          // BoxShadow(
          //   color: Theme.of(context).brightness == Brightness.dark
          //       ? AppColors.shadowDark.withValues(alpha: 0.1)
          //       : AppColors.shadowLight.withValues(alpha: 0.3),
          //   blurRadius: 15, // Softer shadow
          //   spreadRadius: 2, // Slight spread for a natural look
          //   offset: const Offset(0, 8), // Subtle vertical offset
          // ),
        ],
        borderRadius: BorderRadius.circular(12), // Slightly larger radius
      ),
      child: child,
    );
  }
}
