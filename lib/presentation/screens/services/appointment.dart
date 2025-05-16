import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medihub_app/core/widgets/services_widgets/appointment_filter_modal.dart';
import 'package:medihub_app/core/widgets/services_widgets/empty_appointment_view.dart';
import 'package:medihub_app/core/widgets/login_widgets/button.dart';
import 'package:medihub_app/core/widgets/appbar.dart';
import 'package:medihub_app/core/widgets/input_field.dart';
import 'package:medihub_app/models/vaccine.dart';
import 'package:medihub_app/presentation/screens/services/cart.dart';
import 'package:medihub_app/presentation/screens/services/vaccine_list.dart';
import 'package:medihub_app/presentation/screens/home/navigation.dart';
import 'package:medihub_app/core/widgets/button2.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

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
      appBar: AppbarWidget(
        title: 'Lịch Hẹn',
        icon: Icons.add,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) =>
                      const VaccinationBookingScreen(), // Điều hướng đến màn hình cụ thể
            ),
          );
        },
      ),
      body: Column(
        children: [
          _buildAppointmentHeader(),
          const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
          const Expanded(child: EmptyAppointmentView()),
          _buildBookAppointmentButton(),
        ],
      ),
    );
  }

  Widget _buildAppointmentHeader() {
    return Container(
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
                const Icon(Icons.filter_list),
                const SizedBox(width: 4),
                Text(
                  'Lọc',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookAppointmentButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: PrimaryButton(
        text: 'ĐẶT LỊCH HẸN',
        borderRadius: 40,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) =>
                      const VaccinationBookingScreen(), // Điều hướng đến màn hình cụ thể
            ),
          );
        },
      ),
    );
  }
}

class VaccinationBookingScreen extends StatefulWidget {
  const VaccinationBookingScreen({super.key});

  @override
  State<VaccinationBookingScreen> createState() =>
      _VaccinationBookingScreenState();
}

class _VaccinationBookingScreenState extends State<VaccinationBookingScreen> {
  String? _selectedCenter;
  final FocusNode _focusNode = FocusNode();
  DateTime? _selectedDate;
  Vaccine? selectedVaccine;

  final List<String> _selectedVaccines = [];
  final Color _primaryColor = const Color(0xFF019BD3);
  final Color _secondaryColor = const Color(0xA701CBEE);

  String? _facilityValue;
  final List<String> _facilityOptions = [
    'Bệnh viện Đa khoa Quốc tế Vinmec',
    'Bệnh viện Nhiệt đới Trung ương',
    'Trung tâm Y tế dự phòng Hà Nội',
    'Bệnh viện Bạch Mai',
  ];

  void _openCartToSelectVaccine() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartScreen(isFromBookingScreen: true),
      ),
    );

    if (result != null && result is Vaccine) {
      setState(() {
        selectedVaccine = result;
      });
    }
  }

  void _openVaccineListToSelectVaccine() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => const VaccineListScreen(isFromBookingScreen: true),
      ),
    );

    if (result != null && result is Vaccine) {
      setState(() {
        selectedVaccine = result;
      });
      print('Vắc xin được chọn: ${selectedVaccine!.name}');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2026),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: _primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        title: 'Đặt lịch tiêm',
        icon: Icons.home_rounded,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NavigationBottom()),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.4),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Phần thông tin người tiêm
              const Text(
                'Người tiêm: Kieu Van',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 2),
              const Divider(height: 24),

              // Phần chọn trung tâm
              DropdownField(
                label: 'Chọn trung tâm mong muốn tiêm',
                value: _facilityValue,
                items: _facilityOptions,
                isRequired: true,
                onChanged: (newValue) {
                  setState(() {
                    _facilityValue = newValue;
                  });
                },
                hintText: 'Chọn trung tâm',
                focusNode: _focusNode,
              ),
              const SizedBox(height: 16),

              // Phần chọn ngày
              _buildSectionTitle('Chọn ngày mong muốn tiêm'),
              SizedBox(height: 8),
              InkWell(
                onTap: () => _selectDate(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.4, color: Colors.grey.shade600),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today),
                      const SizedBox(width: 16),
                      Text(
                        _selectedDate != null
                            ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
                            : 'Chọn ngày tiêm',
                        style: TextStyle(
                          color:
                              _selectedDate != null
                                  ? Colors.black
                                  : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Phần chọn vắc xin
              _buildSectionTitle('Chọn vắc xin'),
              SizedBox(height: 8),
              // Danh sách vắc xin đã chọn
              if (_selectedVaccines.isNotEmpty) ...[
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _selectedVaccines.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        title: Text(_selectedVaccines[index]),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              _selectedVaccines.removeAt(index);
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
              ] else ...[
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Danh sách vắc xin chọn mua trống',
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BuildButton3(
                    text: 'Thêm từ giỏ',
                    textSize: 14,
                    width: 150,
                    height: 42,
                    onPressed: () {
                      _openCartToSelectVaccine();
                    },
                  ),

                  BuildButton4(
                    text: 'Thêm mới',
                    textSize: 14,
                    width: 150,
                    height: 42,
                    onPressed: () {
                      _openVaccineListToSelectVaccine();
                    },
                  ),
                ],
              ),
              const Divider(height: 32),

              // Tổng cộng
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tổng cộng',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '0 VNĐ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Nút xác nhận
              PrimaryButton(
                text: 'XÁC NHẬN',
                borderRadius: 40,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: title, style: TextStyle(fontSize: 16)),
          TextSpan(
            text: ' *',
            style: TextStyle(fontSize: 16, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
