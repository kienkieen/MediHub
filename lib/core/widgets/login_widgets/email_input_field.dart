import 'package:flutter/material.dart';
import 'package:medihub_app/core/utils/validators.dart';

class EmailInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final TextInputAction textInputAction;

  const EmailInputField({
    super.key,
    required this.controller,
    this.label = 'Email',
    this.hintText = 'Nhập email',
    this.onChanged,
    this.validator,
    this.focusNode,
    this.textInputAction = TextInputAction.next,
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
          focusNode: focusNode,
          validator: validator ?? Validators.validateEmailOrPhone,
          textInputAction: textInputAction,
          onChanged: onChanged,
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
          ),
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }
}
