import 'package:flutter/material.dart';

class BuildButton2 extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onPressed;
  final Color textColor;
  final double height;
  final double width;
  final double borderRadius;

  const BuildButton2({
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
            colors: [
              const Color(0xFF2F8CD8),
              const Color(0xFF2F8CD8),
              Colors.lightBlueAccent,
            ],
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

class BuildButton3 extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onPressed;
  final double height;
  final double width;
  final double textSize;

  const BuildButton3({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.height = 48,
    this.width = double.infinity,
    this.textSize = 18,
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
          color: const Color(0xFF2F8CD8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white, size: 23),
              SizedBox(width: 10),
            ],
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: textSize,
                fontFamily: 'Calistoga',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildButton4 extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onPressed;
  final double height;
  final double width;
  final double textSize;

  const BuildButton4({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.height = 48,
    this.width = double.infinity,
    this.textSize = 18,
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFF2F8CD8), width: 1.2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            if (icon != null) ...[
              Icon(icon, color: const Color(0xFF2F8CD8), size: 23),
              SizedBox(width: 5),
            ],
            Text(
              text,
              style: TextStyle(
                color: const Color(0xFF2F8CD8),
                fontSize: textSize,
                fontFamily: 'Calistoga',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
