// Reusable ServiceButton widget
import 'package:crmacsinsights/Core/Constants/context_extention.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Core/Constants/Colors.dart';
import '../../../Core/Constants/text_styles.dart';

class ServiceButton extends StatelessWidget {
  final String text;
  final String assetPath;
  final VoidCallback onTap;
  final Color? color;
  final Color? textColor;
  final Color? iconColor;


  const ServiceButton({
    Key? key,
    required this.text,
    required this.assetPath,
    required this.onTap,
    this.color,
    this.textColor,
    this.iconColor,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(12),
      color: color ?? context.cardColor.color,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        splashColor: Theme.of(context).primaryColor.withAlpha(51),
        highlightColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: 60,
          child: Row(
            children: [
              Image.asset(
                assetPath,
                height: 25,
                width: 25,
                color: iconColor ?? context.icons.color,
              ),
              SizedBox(width: 20),
              Text(
                text,
                style: AppTextStyles.SmallCaptionBold.copyWith(
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}// Usage example:
