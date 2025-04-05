import 'package:flutter/material.dart';

class SocialLoginOptions extends StatelessWidget {
  final double spacing;
  final double buttonSize;
  final double iconSize;

  const SocialLoginOptions({
    super.key,
    this.spacing = 16,
    this.buttonSize = 40,
    this.iconSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton(Icons.message, () {
          // Messenger login
        }, Colors.blueAccent),
        SizedBox(width: spacing),
        _buildSocialButton(Icons.facebook, () {
          // Facebook login
        }, Colors.blue),
        SizedBox(width: spacing),
        _buildSocialButton(Icons.g_mobiledata, () {
          // Google login
        }, Colors.red),
        SizedBox(width: spacing),
        _buildSocialButton(Icons.apple, () {
          // Apple login
        }, Colors.black),
      ],
    );
  }

  Widget _buildSocialButton(IconData icon, VoidCallback onPressed, Color iconColor) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Center(
          child: Icon(
            icon,
            size: iconSize,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}