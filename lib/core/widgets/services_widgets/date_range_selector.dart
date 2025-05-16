import 'package:flutter/material.dart';

class DateRangeSelector extends StatelessWidget {
  final DateTime? fromDate;
  final DateTime? toDate;
  final Function(DateTime) onFromDateChanged;
  final Function(DateTime) onToDateChanged;

  const DateRangeSelector({
    super.key,
    this.fromDate,
    this.toDate,
    required this.onFromDateChanged,
    required this.onToDateChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => _selectMonth(context, true),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[500]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Text(
                      fromDate != null ? _formatDate(fromDate!) : 'Từ tháng',
                      style: TextStyle(
                        color:
                            fromDate != null
                                ? Colors.black
                                : Colors.grey.shade500,
                        fontSize: 14,
                        fontWeight:
                            fromDate != null
                                ? FontWeight.w500
                                : FontWeight.normal,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.calendar_month, color: const Color(0xFF2F8CD8)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            '-',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: () => _selectMonth(context, false),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[500]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Text(
                      toDate != null ? _formatDate(toDate!) : 'Đến tháng',
                      style: TextStyle(
                        color:
                            toDate != null
                                ? Colors.black
                                : Colors.grey.shade500,
                        fontSize: 14,
                        fontWeight:
                            toDate != null
                                ? FontWeight.w500
                                : FontWeight.normal,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.calendar_month, color: const Color(0xFF2F8CD8)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Format the date to show only month and year
  String _formatDate(DateTime date) {
    // Format as "MM/yyyy"
    return "${date.month.toString().padLeft(2, '0')}/${date.year}";
  }

  // Show month picker dialog
  Future<void> _selectMonth(BuildContext context, bool isFromDate) async {
    final DateTime initialDate =
        isFromDate
            ? fromDate ?? DateTime.now()
            : toDate ??
                (fromDate != null
                    ? fromDate!.add(const Duration(days: 31))
                    : DateTime.now());

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDatePickerMode: DatePickerMode.year,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      // Create a new DateTime with just the year and month, day set to 1
      final DateTime monthStart = DateTime(picked.year, picked.month, 1);

      if (isFromDate) {
        onFromDateChanged(monthStart);
      } else {
        onToDateChanged(monthStart);
      }
    }
  }
}
