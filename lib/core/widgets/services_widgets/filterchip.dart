import 'package:flutter/material.dart';

class CustomFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  const CustomFilterChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FilterChip(
          label: Text(
            label,
            style: TextStyle(
              color:
                  isSelected ? const Color(0xFF206BA8) : Colors.grey.shade800,
              fontWeight: FontWeight.w600,
            ),
          ),
          selected: isSelected,
          onSelected: onSelected,
          backgroundColor: Colors.white,
          selectedColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color:
                  isSelected ? const Color(0xFF2E85CC) : Colors.grey.shade500,
              width: 1.5,
            ),
          ),
          elevation: 0,
          showCheckmark: false,
        ),
        if (isSelected)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 35, 103, 220),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, size: 14, color: Colors.white),
            ),
          ),
      ],
    );
  }
}
