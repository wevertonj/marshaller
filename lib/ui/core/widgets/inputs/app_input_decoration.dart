import 'package:flutter/material.dart';
import 'package:marshaller/ui/core/theme/extensions/theme_extensions.dart';

class AppInputDecoration {
  static InputDecoration build({
    required BuildContext context,
    required String labelText,
    Widget? suffixIcon,
    String? helperText,
    String? prefixText,
  }) {
    return InputDecoration(
      labelText: labelText,
      border: InputBorder.none,
      contentPadding: EdgeInsets.all(Theme.of(context).layout.padding.small),
      suffixIcon: suffixIcon,
      helperText: helperText,
      prefixText: prefixText,
    );
  }
}
