import 'package:flutter/material.dart';
import 'custom_checkbox_item.dart';
import 'package:medihub_app/core/widgets/button2.dart';
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            mainAxisSize: MainAxisSize.min,
            children: [
              _buildModalHeader(),

              // Status section
              Text('Trạng thái', style: TextStyle(fontSize: 16)),

              const SizedBox(height: 5),
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
              SizedBox(height: 10),
              const Divider(height: 1, color: Colors.grey),

              const SizedBox(height: 16),
              // Appointment type section
              Text('Loại đặt hẹn', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 5),
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
              const SizedBox(height: 16),
              const Divider(height: 1, color: Colors.grey),

              const SizedBox(height: 16),
              // Date range section
              Text('Khoảng thời gian', style: TextStyle(fontSize: 16)),

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
            child: BuildButton3(
              text: 'Lọc',
              onPressed: _resetFilters,
              icon: Icons.filter_list,
              height: 48,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: BuildButton4(
              onPressed: () {
                Navigator.pop(context);
              },
              text: 'Xoá lọc',
              icon: Icons.clear,
            ),
          ),
        ],
      ),
    );
  }
}
