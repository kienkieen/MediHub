import 'package:flutter/material.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onPressed;
  final IconData? icon;

  const AppbarWidget({
    super.key,
    required this.title,
    this.onPressed,
    this.icon,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      centerTitle: true,

      leading: IconButton(
        icon: Icon(Icons.keyboard_backspace, size: 28, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
      ),

      actions:
          icon != null
              ? [
                IconButton(
                  icon: Icon(icon, color: Colors.white, size: 30),
                  onPressed: onPressed,
                ),
              ]
              : null,

      elevation: 0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0099CC), Color(0xFF0099CC), Color(0xA701CBEE)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      ),
    );
  }
}
