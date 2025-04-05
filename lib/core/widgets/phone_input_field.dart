import 'package:flutter/material.dart';

class PhoneInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String countryCode;
  final String flagAsset;

  const PhoneInputField({
    super.key,
    required this.controller,
    this.hintText = 'Số điện thoại',
    this.countryCode = '+84',
    this.flagAsset = 'assets/images/vietnam_flag.png',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          // Country code selector
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              border: Border(right: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              children: [
                Image.asset(
                  flagAsset,
                  width: 24,
                  height: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  countryCode,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          // Phone input
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              ),
              keyboardType: TextInputType.phone,
            ),
          ),
        ],
      ),
    );
  }
}