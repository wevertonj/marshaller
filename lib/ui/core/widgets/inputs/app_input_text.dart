import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marshaller/ui/core/widgets/inputs/app_input_container.dart';
import 'package:marshaller/ui/core/widgets/inputs/app_input_decoration.dart';

class AppInputText extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final bool readOnly;
  const AppInputText({
    super.key,
    required this.controller,
    required this.labelText,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.maxLines = 1,
    this.readOnly = false,
  });
  @override
  Widget build(BuildContext context) {
    return AppInputContainer(
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: AppInputDecoration.build(
          context: context,
          labelText: labelText,
        ),
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        maxLines: maxLines,
        readOnly: readOnly,
      ),
    );
  }
}
