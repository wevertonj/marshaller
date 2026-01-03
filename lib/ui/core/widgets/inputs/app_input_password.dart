import 'package:flutter/material.dart';
import 'package:marshaller/ui/core/widgets/inputs/app_input_container.dart';
import 'package:marshaller/ui/core/widgets/inputs/app_input_decoration.dart';

class AppInputPassword extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  const AppInputPassword({
    super.key,
    required this.controller,
    required this.labelText,
    this.onChanged,
    this.validator,
  });
  @override
  State<AppInputPassword> createState() => _AppInputPasswordState();
}

class _AppInputPasswordState extends State<AppInputPassword> {
  bool _obscureText = true;
  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppInputContainer(
      child: TextFormField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        validator: widget.validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: _obscureText,
        decoration: AppInputDecoration.build(
          context: context,
          labelText: widget.labelText,
          suffixIcon: IconButton(
            icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
            onPressed: _toggleObscureText,
          ),
        ),
      ),
    );
  }
}
