import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medihub_app/core/widgets/services_widgets/appointment_filter_modal.dart';
import 'package:medihub_app/core/widgets/services_widgets/empty_appointment_view.dart';
import 'package:medihub_app/core/widgets/login_widgets/button.dart';
import 'package:medihub_app/core/widgets/appbar.dart';
import 'package:medihub_app/core/widgets/input_field.dart';
import 'package:medihub_app/firebase_helper/firebase_helper.dart';
import 'package:medihub_app/main.dart';
import 'package:medihub_app/models/booking.dart';
import 'package:medihub_app/models/vaccine.dart';
import 'package:medihub_app/presentation/screens/login/login.dart';
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
  List<Booking> _allBookings = [];
  List<Booking> _filteredBookings = [];

  bool _filterNotConfirmed = false;
  bool _filterConfirmed = false;
  bool _filterCancelled = false;
  DateTime? _filterFromDate;
  DateTime? _filterToDate;

  @override
  void initState() {
    super.initState();
    _fetchBookings();
  }

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => AppointmentFilterModal(
            notConfirmed: _filterNotConfirmed,
            confirmed: _filterConfirmed,
            cancelled: _filterCancelled,
            fromDate: _filterFromDate,
            toDate: _filterToDate,

            onApplyFilters: (
              notConfirmed,
              confirmed,
              cancelled,
              fromDate,
              toDate,
            ) {
              setState(() {
                _filterNotConfirmed = notConfirmed;
                _filterConfirmed = confirmed;
                _filterCancelled = cancelled;
                _filterFromDate = fromDate;
                _filterToDate = toDate;
                _applyFilters();
              });
            },
          ),
    );
  }

  Future<void> _fetchBookings() async {
    List<Vaccine> vaccines_user1 = [vaccines[0]];
    List<Vaccine> vaccines_user2 = [vaccines[1], vaccines[2]];
    List<Vaccine> vaccines_user3 = [vaccines[1], vaccines[2], vaccines[0]];

    List<Map<String, dynamic>> bookingData = [
      {
        'idBooking': 'b2',
        'idUser': 'user123',
        'bookingCenter': 'Bệnh viện Đa khoa Quốc tế Vinmec',
        'dateBooking': '2025-05-25',
        'lstVaccine': vaccines_user1.map((vaccine) => vaccine.toMap()).toList(),
        'isConfirmed': 1, // Đã xác nhận
      },
      {
        'idBooking': 'b1',
        'idUser': 'user123',
        'bookingCenter': 'Bệnh viện Bạch Mai',
        'dateBooking': '2025-05-15',
        'lstVaccine': vaccines_user2.map((vaccine) => vaccine.toMap()).toList(),
        'isConfirmed': 0, // Chưa xác nhận
      },
      {
        'idBooking': 'b3',
        'idUser': 'user456',
        'bookingCenter': 'Phòng khám Sài Gòn',
        'dateBooking': '2025-06-01',
        'lstVaccine': [vaccines[0].toMap()],
        'isConfirmed': 1, // Đã xác nhận
      },
      {
        'idBooking': 'b4',
        'idUser': 'user789',
        'bookingCenter': 'Trung tâm y tế Gia Định',
        'dateBooking': '2025-05-20',
        'lstVaccine': vaccines_user3.map((vaccine) => vaccine.toMap()).toList(),
        'isConfirmed': 0, // Chưa xác nhận
      },
      {
        'idBooking': 'b5',
        'idUser': 'user123',
        'bookingCenter': 'Bệnh viện Nhi Đồng 1',
        'dateBooking': '2025-05-10',
        'lstVaccine': [vaccines[2].toMap()],
        'isConfirmed': -1, // Đã hủy
      },
    ];

    setState(() {
      _allBookings = bookingData.map((data) => Booking.fromMap(data)).toList();
      _applyFilters();
    });
  }

  void _applyFilters() {
    List<Booking> tempBookings = List.from(_allBookings);

    List<int> selectedStatus = [];
    if (_filterConfirmed) selectedStatus.add(1);
    if (_filterNotConfirmed) selectedStatus.add(0);
    if (_filterCancelled) selectedStatus.add(-1);

    if (selectedStatus.isNotEmpty) {
      tempBookings =
          tempBookings
              .where((b) => selectedStatus.contains(b.isConfirmed))
              .toList();
    }
    print('from: $_filterFromDate, to: $_filterToDate');

    if (_filterFromDate != null) {
      tempBookings =
          tempBookings.where((b) {
            final bookingDay = DateTime(
              b.dateBooking.year,
              b.dateBooking.month,
              b.dateBooking.day,
            );
            final fromDay = DateTime(
              _filterFromDate!.year,
              _filterFromDate!.month,
              _filterFromDate!.day,
            );
            return bookingDay.compareTo(fromDay) >= 0;
          }).toList();
    }
    if (_filterToDate != null) {
      tempBookings =
          tempBookings.where((b) {
            final bookingDay = DateTime(
              b.dateBooking.year,
              b.dateBooking.month,
              b.dateBooking.day,
            );
            final toDay = DateTime(
              _filterToDate!.year,
              _filterToDate!.month,
              _filterToDate!.day,
            );
            return bookingDay.compareTo(toDay) <= 0;
          }).toList();
    }

    setState(() {
      _filteredBookings = tempBookings;
    });
  }

  Future<void> _cancelBooking(int index) async {
    final bookingToCancel = _filteredBookings[index];
    final originalIndex = _allBookings.indexOf(bookingToCancel);

    if (originalIndex != -1) {
      setState(() {
        _allBookings[originalIndex].isConfirmed = -1;
        _applyFilters();
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Đã hủy lịch tiêm')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarWidget(
        title: 'Lịch Hẹn',
        icon: Icons.filter_list,
        onPressed: _showFilterModal,
      ),
      body: Column(
        children: [
          _buildAppointmentHeader(),
          const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
          Expanded(
            child:
                _filteredBookings.isEmpty
                    ? const EmptyAppointmentView()
                    : ListView.builder(
                      itemCount: _filteredBookings.length,
                      itemBuilder: (context, index) {
                        final booking = _filteredBookings[index];
                        return _buildBookingCard(
                          booking,
                          () => _cancelBooking(index),
                        );
                      },
                    ),
          ),
          _buildBookAppointmentButton(),
        ],
      ),
    );
  }

  // Helper function to get status text
  String _getBookingStatusText(int status) {
    switch (status) {
      case 0:
        return 'Chưa xác nhận';
      case 1:
        return 'Đã xác nhận';
      case -1:
        return 'Đã hủy';
      default:
        return 'Không xác định';
    }
  }

  // Helper function to get status color
  Color _getBookingStatusColor(int status) {
    switch (status) {
      case 0:
        return Colors.orange; // Chưa xác nhận
      case 1:
        return Colors.green; // Đã xác nhận
      case -1:
        return Colors.red; // Đã hủy
      default:
        return Colors.grey;
    }
  }

  Widget _buildBookingCard(Booking booking, VoidCallback onCancel) {
    // Tính toán tổng chi phí từ danh sách vắc xin
    double _calculateTotalCost(List<Vaccine> vaccines) {
      return vaccines.fold(0, (sum, vaccine) => sum + vaccine.price);
    }

    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: _getBookingStatusColor(booking.isConfirmed),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Lịch hẹn #${booking.idBooking}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Đã huỷ lịch hẹn')),
                    );
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Thông báo'),
                          content: const Text('Bạn có chắc muốn huỷ lịch hẹn?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                onCancel();
                                Navigator.of(context).pop();
                              },
                              child: const Text('Có'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Không'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  DateFormat('dd/MM/yyyy').format(booking.dateBooking),
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.info_outline, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  _getBookingStatusText(booking.isConfirmed),
                  style: TextStyle(
                    fontSize: 14,
                    color: _getBookingStatusColor(booking.isConfirmed),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    booking.bookingCenter,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Divider(height: 16),
            const SizedBox(height: 4),
            const Text(
              'Danh sách vắc xin:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            ...booking.lstVaccine.map(
              (vaccine) => Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(vaccine.name, style: const TextStyle(fontSize: 14)),
                    Text(
                      NumberFormat.currency(
                        locale: 'vi',
                        symbol: 'VND',
                      ).format(vaccine.price),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Tổng cộng:',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  NumberFormat.currency(
                    locale: 'vi',
                    symbol: 'VND',
                  ).format(_calculateTotalCost(booking.lstVaccine)),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
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
  double sumBill = 0;

  final List<Vaccine> _selectedVaccines = [];
  final Color _primaryColor = const Color(0xFF019BD3);
  final Color _secondaryColor = const Color(0xA701CBEE);

  String? _facilityValue;
  final List<String> _facilityOptions = [
    'Bệnh viện Đa khoa Quốc tế Vinmec',
    'Bệnh viện Nhiệt đới Trung ương',
    'Trung tâm Y tế dự phòng Hà Nội',
    'Bệnh viện Bạch Mai',
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (userLogin == null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(isNewLoginl: false),
          ),
        );
      }
    });
  }

  void _plusAllBill(Vaccine vaccine) {
    sumBill += vaccine.price;
  }

  void _minusAllBill(Vaccine vaccine) {
    sumBill -= vaccine.price;
  }

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
        _selectedVaccines.add(result);
        _plusAllBill(result);
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
        _selectedVaccines.add(result);
        _plusAllBill(result);
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
              Text(
                'Người tiêm: ${useMainLogin!.fullName}',
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
                        title: Text(_selectedVaccines[index].name),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              _selectedVaccines.removeAt(index);
                              _minusAllBill(_selectedVaccines[index]);
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tổng cộng',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    NumberFormat.currency(
                      locale: 'vi',
                      symbol: 'VND',
                    ).format(sumBill),
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
                onPressed: () {
                  _submitBooking();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitBooking() async {
    if (_facilityValue != null &&
        _facilityValue!.isNotEmpty &&
        _selectedDate != null &&
        _selectedDate!.toString().isNotEmpty &&
        _selectedVaccines.isNotEmpty) {
      Booking bk = Booking(
        idBooking: '',
        idUser: useMainLogin!.userId,
        bookingCenter: _facilityValue!,
        dateBooking: _selectedDate!,
        lstVaccine: _selectedVaccines,
      );
      bool up = await insertDataAutoID("DATLICHTIEM", bk.toMap());
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Đang đặt lịch...')));
      if (up) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Đặt lịch thành công')));
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Thông báo'),
              content: const Text('Bạn muốn đặt tiếp không?'),
              actions: [
                TextButton(onPressed: () {}, child: const Text('Ok')),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AppointmentScreen(),
                      ),
                    );
                  },
                  child: const Text('Xem lịch đã đặt'),
                ),
              ],
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Thông báo'),
            content: const Text('Vui lòng nhập đầy đủ thông tin'),
            actions: [TextButton(onPressed: () {}, child: const Text('Ok'))],
          );
        },
      );
    }
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
