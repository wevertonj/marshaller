import 'package:flutter/material.dart';
import 'package:marshaller/ui/core/theme/app_layout_theme.dart';

extension AppLayoutExtension on ThemeData {
  AppLayoutTheme get layout => extension<AppLayoutTheme>()!;
}
