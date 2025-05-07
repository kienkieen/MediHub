import 'package:flutter/material.dart';
import 'filter_section_header.dart';
import 'custom_checkbox_item.dart';
import 'date_range_selector.dart';

class AppointmentFilterModal extends StatefulWidget {
  const AppointmentFilterModal({super.key});

  @override
  State<AppointmentFilterModal> createState() => _AppointmentFilterModalState();
}

class _AppointmentFilterModalState extends State<AppointmentFilterModal> {
  // Filter state values
  bool notConfirmed = false;
  bool confirmed = false;
  bool cancelled = false;
  bool vipAppointment = false;
  bool regularAppointment = false;
  
  // Date range states
  DateTime? fromDate;
  DateTime? toDate;
  
  void _resetFilters() {
    setState(() {
      notConfirmed = false;
      confirmed = false;
      cancelled = false;
      vipAppointment = false;
      regularAppointment = false;
      fromDate = null;
      toDate = null;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildModalHeader(),
            
            // Status section
            const FilterSectionHeader(title: 'Trạng thái'),
            
            // Status checkboxes
            CustomCheckboxItem(
              label: 'Chưa xác nhận',
              isChecked: notConfirmed,
              onChanged: (value) {
                setState(() {
                  notConfirmed = value;
                });
              },
            ),
            CustomCheckboxItem(
              label: 'Đã xác nhận',
              isChecked: confirmed,
              onChanged: (value) {
                setState(() {
                  confirmed = value;
                });
              },
            ),
            CustomCheckboxItem(
              label: 'Đã hủy',
              isChecked: cancelled,
              onChanged: (value) {
                setState(() {
                  cancelled = value;
                });
              },
            ),
            
            // Appointment type section
            const FilterSectionHeader(title: 'Loại đặt hẹn'),
            
            // Appointment type checkboxes
            CustomCheckboxItem(
              label: 'Đặt khám vip',
              isChecked: vipAppointment,
              onChanged: (value) {
                setState(() {
                  vipAppointment = value;
                });
              },
            ),
            CustomCheckboxItem(
              label: 'Đặt khám thường',
              isChecked: regularAppointment,
              onChanged: (value) {
                setState(() {
                  regularAppointment = value;
                });
              },
            ),
            
            // Date range section
            const FilterSectionHeader(title: 'Khoảng thời gian'),
            
            // Date range pickers
            DateRangeSelector(
              fromDate: fromDate,
              toDate: toDate,
              onFromDateChanged: (date) {
                setState(() {
                  fromDate = date;
                  // If toDate is before fromDate, update toDate
                  if (toDate != null && toDate!.isBefore(date)) {
                    toDate = DateTime(date.year, date.month + 1, 1);
                  }
                });
              },
              onToDateChanged: (date) {
                setState(() {
                  toDate = date;
                  // If fromDate is after toDate, update fromDate
                  if (fromDate != null && fromDate!.isAfter(date)) {
                    fromDate = DateTime(date.year, date.month - 1, 1);
                  }
                });
              },
            ),
            
            _buildActionButtons(),
            
            const SizedBox(height: 16), // Extra bottom padding for safe area
          ],
        ),
      ),
    );
  }

  Widget _buildModalHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 48), // For balancing the close button
          const Expanded(
            child: Center(
              child: Text(
                'Bộ lọc',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Đóng',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: _resetFilters,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: const BorderSide(color: Colors.blue),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Xoá lọc',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // Apply filters and close the modal
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.filter_list, size: 18, color: Colors.white,),
                  SizedBox(width: 8),
                  Text(
                    'Lọc',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}