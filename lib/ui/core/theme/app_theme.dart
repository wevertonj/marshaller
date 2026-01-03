import 'package:flutter/material.dart';
import 'package:marshaller/ui/core/theme/app_layout_theme.dart';

abstract class AppTheme {
  static ThemeData light(Color seedColor) => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.light,
    ),
    extensions: const <ThemeExtension<dynamic>>[AppLayoutTheme()],
  );
  static ThemeData dark(Color seedColor) => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
    ),
    extensions: const <ThemeExtension<dynamic>>[AppLayoutTheme()],
  );
}
