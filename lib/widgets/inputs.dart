import 'package:flutter/material.dart';
class CustomTextField extends StatelessWidget {
  final String labelText;
  final String Function(String?)? validator;
 final void Function(String?)? onSaved;

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.validator,
    required this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          gapPadding: 5.0,
        ),
      ),
      validator: validator,
      onSaved: onSaved,
    );
  }
}