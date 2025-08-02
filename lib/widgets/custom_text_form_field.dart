import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? labelText;
  final String? hintText;
  final IconData? prefixIcon;
  const CustomTextFormField({
    super.key,
    this.controller,
    this.keyboardType,
    this.labelText,
    this.hintText,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey),
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: prefixIcon == null ? null : Icon(prefixIcon),
      ),
    );
  }
}
