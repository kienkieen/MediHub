import 'package:flutter/material.dart';

class PrimaryGradientButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onPressed;
  final Color textColor;
  final double height;
  final double width;
  final double borderRadius;

  const PrimaryGradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.textColor = Colors.white,
    this.height = 48,
    this.width = double.infinity,
    this.borderRadius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width, height),
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      ),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF019BD3), Color(0xA701CBEE)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(width: 15),
            if (icon != null) ...[
              Icon(icon, color: Colors.white, size: 23),
              SizedBox(width: 10),
            ],
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Oswald',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
