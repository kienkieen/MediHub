import 'package:flutter/material.dart';

class CustomCheckboxItem extends StatelessWidget {
  final String label;
  final bool isChecked;
  final Function(bool) onChanged;
  
  const CustomCheckboxItem({
    Key? key,
    required this.label,
    required this.isChecked,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!isChecked);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isChecked ? Colors.blue : Colors.grey[400]!,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(4),
                color: isChecked ? Colors.blue.withOpacity(0.1) : Colors.transparent,
              ),
              child: isChecked
                  ? const Icon(
                      Icons.check,
                      size: 18,
                      color: Colors.blue,
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}