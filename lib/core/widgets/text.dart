import 'package:flutter/material.dart';

class TextDivider extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color dividerColor;
  final double horizontalPadding;

  const TextDivider({
    super.key,
    required this.text,
    this.textColor = Colors.grey,
    this.dividerColor = Colors.grey,
    this.horizontalPadding = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: dividerColor,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: dividerColor,
          ),
        ),
      ],
    );
  }
}

class AuthLinkText extends StatelessWidget {
  final String text;
  final String linkText;
  final VoidCallback onLinkTap;
  final Color textColor;
  final Color linkColor;

  const AuthLinkText({
    super.key,
    required this.text,
    required this.linkText,
    required this.onLinkTap,
    this.textColor = Colors.grey,
    this.linkColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(color: textColor, fontSize: 14),
        ),
        TextButton(
          onPressed: onLinkTap,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(50, 30),
          ),
          child: Text(
            linkText,
            style: TextStyle(
              color: linkColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}