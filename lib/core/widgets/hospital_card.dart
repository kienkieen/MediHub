import 'package:flutter/material.dart';

class HospitalCard extends StatelessWidget {
  final String name;
  final String imagePath; // Đường dẫn hình ảnh

  const HospitalCard({super.key, required this.name, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8), // Bo góc cho hình ảnh
            child: Image.asset(
              imagePath, // Đường dẫn hình ảnh
              width: 50, // Chiều rộng hình ảnh
              height: 50, // Chiều cao hình ảnh
              fit: BoxFit.cover, // Đảm bảo hình ảnh vừa khung
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}