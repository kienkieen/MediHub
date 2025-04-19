import 'package:flutter/material.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AppointmentFilterModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Đặt hẹn',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              // Handle add button press
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.white,
            child: Row(
              children: [
                const Text(
                  'Danh sách lịch hẹn (0)',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: _showFilterModal,
                  child: Row(
                    children: [
                      const Icon(Icons.filter_list, color: Colors.blue),
                      const SizedBox(width: 4),
                      Text(
                        'Lọc',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.calendar_today_outlined,
                      size: 60,
                      color: Colors.grey[400],
                    ),
                    // child: Image.asset(
                    //   'assets/icons/grid_service/schedule.png', // Đường dẫn đến ảnh
                    //   width: 60, // Chiều rộng của ảnh
                    //   height: 60, // Chiều cao của ảnh
                    //   fit: BoxFit.contain, // Đảm bảo ảnh vừa khung
                    // ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Quý khách chưa có lịch hẹn',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E4053),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'Tạo đặt hẹn để tiết kiệm thời gian khi đến tiêm chủng tại VNVC',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF7F8C8D),
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                // Handle appointment booking
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Đặt lịch hẹn',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppointmentFilterModal extends StatefulWidget {
  const AppointmentFilterModal({Key? key}) : super(key: key);

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
            // Filter header
            Padding(
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
            ),
            
            // Status section
            _buildSectionHeader('Trạng thái'),
            
            // Status checkboxes
            _buildCheckboxItem('Chưa xác nhận', notConfirmed, (value) {
              setState(() {
                notConfirmed = value;
              });
            }),
            _buildCheckboxItem('Đã xác nhận', confirmed, (value) {
              setState(() {
                confirmed = value;
              });
            }),
            _buildCheckboxItem('Đã hủy', cancelled, (value) {
              setState(() {
                cancelled = value;
              });
            }),
            
            // Appointment type section
            _buildSectionHeader('Loại đặt hẹn'),
            
            // Appointment type checkboxes
            _buildCheckboxItem('Đặt khám vip', vipAppointment, (value) {
              setState(() {
                vipAppointment = value;
              });
            }),
            _buildCheckboxItem('Đặt khám thường', regularAppointment, (value) {
              setState(() {
                regularAppointment = value;
              });
            }),
            
            // Date range section
            _buildSectionHeader('Khoảng thời gian'),
            
            // Date range pickers
            _buildDateRangePickers(),
            
            // Action buttons
            Padding(
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.filter_list, size: 18),
                          const SizedBox(width: 8),
                          const Text(
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
            ),
            const SizedBox(height: 16), // Extra bottom padding for safe area
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey[50],
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16, 
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckboxItem(String label, bool isChecked, Function(bool) onChanged) {
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

  Widget _buildDateRangePickers() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => _selectMonth(true),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Text(
                      fromDate != null ? _formatDate(fromDate!) : 'Từ tháng',
                      style: TextStyle(
                        color: fromDate != null ? Colors.black : Colors.black87,
                        fontSize: 14,
                        fontWeight: fromDate != null ? FontWeight.w500 : FontWeight.normal,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.calendar_month, color: Colors.indigo[700]),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            '-',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: () => _selectMonth(false),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Text(
                      toDate != null ? _formatDate(toDate!) : 'Đến tháng',
                      style: TextStyle(
                        color: toDate != null ? Colors.black : Colors.black87,
                        fontSize: 14,
                        fontWeight: toDate != null ? FontWeight.w500 : FontWeight.normal,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.calendar_month, color: Colors.indigo[700]),
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
  Future<void> _selectMonth(bool isFromDate) async {
    final DateTime initialDate = isFromDate 
        ? fromDate ?? DateTime.now() 
        : toDate ?? (fromDate != null ? fromDate!.add(const Duration(days: 31)) : DateTime.now());
    
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
      
      setState(() {
        if (isFromDate) {
          fromDate = monthStart;
          
          // If toDate is before fromDate, update toDate
          if (toDate != null && toDate!.isBefore(fromDate!)) {
            toDate = DateTime(fromDate!.year, fromDate!.month + 1, 1);
          }
        } else {
          toDate = monthStart;
          
          // If fromDate is after toDate, update fromDate
          if (fromDate != null && fromDate!.isAfter(toDate!)) {
            fromDate = DateTime(toDate!.year, toDate!.month - 1, 1);
          }
        }
      });
    }
  }
}