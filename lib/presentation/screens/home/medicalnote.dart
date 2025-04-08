import 'package:flutter/material.dart';
class MedicalnoteScreen extends StatelessWidget {
  const MedicalnoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Phiếu khám",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}