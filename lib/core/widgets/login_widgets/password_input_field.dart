import 'package:flutter/material.dart';
import 'package:medihub_app/core/utils/validators.dart';

class PasswordInputField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final VoidCallback onToggleVisibility;
  final String label;
  final String hintText;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final TextInputAction textInputAction;

  const PasswordInputField({
    super.key,
    required this.controller,
    required this.obscureText,
    required this.onToggleVisibility,
    this.label = 'Mật khẩu',
    this.hintText = 'Nhập mật khẩu',
    this.validator,
    this.focusNode,
    this.textInputAction = TextInputAction.done,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 17)),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          focusNode: focusNode,
          validator: validator ?? Validators.validatePassword,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade500),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade500),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.blue),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: onToggleVisibility,
            ),
          ),
        ),
      ],
    );
  }
}
