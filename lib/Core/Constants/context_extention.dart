import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;
  TextTheme get texts => Theme.of(this).textTheme;
  IconThemeData get icons => Theme.of(this).iconTheme;
  CardThemeData get cardColor => Theme.of(this).cardTheme;
}
