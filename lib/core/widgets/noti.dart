import 'package:flutter/material.dart';

class buildNoti extends StatelessWidget {
  final String content;
  final Color bgcolor;
  final Color textcolor;
  final IconData? icon;

  const buildNoti({
    super.key,
    required this.content,
    this.icon,
    this.bgcolor = Colors.blue,
    this.textcolor = const Color(0xFF0B6D90),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: bgcolor.withValues(alpha: 0.1)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null) Icon(icon, size: 25, color: textcolor),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              content,
              style: TextStyle(
                color: Color(0xFF0B6D90),
                fontSize: 14,
                height: 1.3,
              ),
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }
}
