import 'package:flutter/material.dart';
import 'custom_checkbox_item.dart'; // Đảm bảo đường dẫn này đúng
import 'package:medihub_app/core/widgets/button2.dart'; // Đảm bảo đường dẫn này đúng
import 'date_range_selector.dart'; // Đảm bảo đường dẫn này đúng

class AppointmentFilterModal extends StatefulWidget {
  // Thay vì nhận AppointmentFilterCriteria, nhận các tham số riêng lẻ
  final bool notConfirmed;
  final bool confirmed;
  final bool cancelled;
  final DateTime? fromDate;
  final DateTime? toDate;
  // Callback để trả về các giá trị lọc đã chọn
  final Function(
    bool notConfirmed,
    bool confirmed,
    bool cancelled,
    DateTime? fromDate,
    DateTime? toDate,
  )?
  onApplyFilters;

  const AppointmentFilterModal({
    super.key,
    required this.notConfirmed,
    required this.confirmed,
    required this.cancelled,
    this.fromDate,
    this.toDate,
    this.onApplyFilters,
  });

  @override
  State<AppointmentFilterModal> createState() => _AppointmentFilterModalState();
}

class _AppointmentFilterModalState extends State<AppointmentFilterModal> {
  // Filter state values - Khởi tạo từ widget.properties
  late bool _notConfirmed;
  late bool _confirmed;
  late bool _cancelled;

  // Date range states - Khởi tạo từ widget.properties
  late DateTime? _fromDate;
  late DateTime? _toDate;

  @override
  void initState() {
    super.initState();
    // Khởi tạo trạng thái bộ lọc từ các tiêu chí được truyền vào
    _notConfirmed = widget.notConfirmed;
    _confirmed = widget.confirmed;
    _cancelled = widget.cancelled;
    _fromDate = widget.fromDate;
    _toDate = widget.toDate;
  }

  void _resetFilters() {
    setState(() {
      _notConfirmed = false;
      _confirmed = false;
      _cancelled = false;
      _fromDate = null;
      _toDate = null;
    });
  }

  // Phương thức để áp dụng bộ lọc và đóng modal
  void _applyFilters() {
    widget.onApplyFilters?.call(
      _notConfirmed,
      _confirmed,
      _cancelled,
      _fromDate,
      _toDate,
    ); // Gọi callback với các giá trị đã chọn
    Navigator.pop(context); // Đóng modal
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
              const Text('Trạng thái', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 5),

              // Status checkboxes
              CustomCheckboxItem(
                label: 'Chưa xác nhận',
                isChecked: _notConfirmed,
                onChanged: (value) {
                  setState(() {
                    _notConfirmed = value;
                  });
                },
              ),
              CustomCheckboxItem(
                label: 'Đã xác nhận',
                isChecked: _confirmed,
                onChanged: (value) {
                  setState(() {
                    _confirmed = value;
                  });
                },
              ),
              CustomCheckboxItem(
                label: 'Đã hủy',
                isChecked: _cancelled,
                onChanged: (value) {
                  setState(() {
                    _cancelled = value;
                  });
                },
              ),
              const SizedBox(height: 10),
              const Divider(height: 1, color: Colors.grey),

              const SizedBox(height: 16),
              // Date range section
              const Text('Khoảng thời gian', style: TextStyle(fontSize: 16)),

              // Date range pickers
              DateRangeSelector(
                fromDate: _fromDate,
                toDate: _toDate,
                onFromDateChanged: (date) {
                  setState(() {
                    _fromDate = date;
                  });
                },
                // Khi chọn ngày kết thúc
                onToDateChanged: (date) {
                  setState(() {
                    _toDate = date;
                  });
                },
              ),

              _buildActionButtons(),

              const SizedBox(height: 16),
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
              onPressed: _applyFilters,
              icon: Icons.filter_list,
              height: 48,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: BuildButton4(
              onPressed: () {
                _resetFilters();
                widget.onApplyFilters?.call(false, false, false, null, null);
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
