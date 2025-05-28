import 'package:flutter/material.dart';
import 'package:medihub_app/core/utils/constants.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isBackButton;

  const AppbarWidget({
    super.key,
    required this.title,
    this.onPressed,
    this.icon,
    required this.isBackButton,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: TextStyle(fontSize: 22, color: Colors.white)),
      centerTitle: true,

      leading:
          isBackButton
              ? IconButton(
                icon: Icon(
                  Icons.keyboard_backspace,
                  size: 28,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
              : null,
      automaticallyImplyLeading: isBackButton ? true : false,
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
      flexibleSpace: Container(decoration: BoxDecoration(color: Colors.blue)),
    );
  }
}
