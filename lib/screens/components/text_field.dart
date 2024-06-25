import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final String? errorMsg;
  final String? Function(String?)? onChanged;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.keyboardType,
    this.suffixIcon,
    this.onTap,
    this.prefixIcon,
    this.validator,
    this.focusNode,
    this.errorMsg,
    this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      focusNode: focusNode,
      onTap: onTap,
      textInputAction: TextInputAction.next,
      onChanged: onChanged,
      style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 17
      ),
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        suffixIconColor: Colors.grey.shade500,
        prefixIcon: prefixIcon,
        prefixIconColor: Colors.grey.shade500,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
        ),
        fillColor: Color(0xFF2C2C2C),
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade600),
        errorText: errorMsg,
      ),
    );
  }
}