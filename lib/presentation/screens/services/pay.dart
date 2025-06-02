import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medihub_app/core/widgets/input_field.dart';
import 'package:medihub_app/core/widgets/appbar.dart';
import 'package:medihub_app/core/widgets/login_widgets/button.dart';
import 'package:medihub_app/firebase_helper/firebase_helper.dart';
import 'package:medihub_app/main.dart';
import 'package:medihub_app/models/booking.dart';
import 'package:medihub_app/models/vaccine.dart';
import 'package:medihub_app/presentation/screens/services/payment_info.dart';

class PaymentScreen extends StatefulWidget {
  final Booking booking;
  const PaymentScreen({super.key, required this.booking});
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? _selectedPaymentMethod;

  void _submitPayment(Booking booking) async {
    bool up = await insertDataAutoID("DATLICHTIEM", booking.toMap());
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Đang đặt lịch...')));
    if (up) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Đặt lịch thành công')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(isBackButton: true, title: 'Thanh toán'),
      body: SizedBox(
        height: MediaQuery.of(context).size.height, // Giới hạn chiều cao
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Thông tin người đặt lịch',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              InputField(
                label: 'Họ tên',
                hintText: useMainLogin!.fullName,
                enable: false,
              ),
              InputField(
                label: 'Số điện thoại',
                hintText: useMainLogin!.phoneNumber,
                enable: false,
              ),
              InputField(
                label: 'Email',
                hintText: useMainLogin!.email,
                enable: false,
              ),
              InputField(
                label: 'Trung tâm tiêm',
                hintText: widget.booking.bookingCenter,
                enable: false,
              ),
              InputField(
                label: 'Ngày mong muốn tiêm',
                hintText: widget.booking.convertDate(
                  widget.booking.dateBooking,
                ),
                enable: false,
              ),
              const SizedBox(height: 8),
              Divider(),
              const SizedBox(height: 8),

              const Text(
                'Thông tin vắc xin đã chọn',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...widget.booking.lstVaccine
                  .map((vaccine) => _buildVaccineItem(vaccine))
                  .toList(),
              const SizedBox(height: 8),
              Divider(),
              const SizedBox(height: 8),

              const Text(
                'Phương thức thanh toán',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              _buildPaymentOption('Thanh toán qua chuyển khoản'),
              _buildPaymentOption('Thanh toán bằng thẻ VISA/MASTER/JCB'),
              _buildPaymentOption('Thanh toán bằng ví thanh toán nội địa'),

              const SizedBox(height: 8),
              Divider(),
              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tổng cộng : ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    NumberFormat.currency(
                      locale: 'vi_VN',
                      symbol: 'VND',
                    ).format(widget.booking.totalPrice),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              PrimaryButton(
                text: 'THANH TOÁN',
                borderRadius: 40,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => PaymentInfoScreen(
                            booking: widget.booking,
                            paymentMethod: _selectedPaymentMethod!,
                          ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16), // Thêm khoảng cách dưới cùng
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVaccineItem(String idvaccine) {
    Vaccine v = allVaccines.where((vaccine) => vaccine.id == idvaccine).first;
    if (v != null) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0, left: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(v.name, style: const TextStyle(fontSize: 16)),
            Text(
              NumberFormat.currency(
                locale: 'vi_VN',
                symbol: 'VND',
              ).format(v.price),
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildPaymentOption(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 14),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Radio<String>(
            value: text,
            groupValue: _selectedPaymentMethod,
            onChanged: (value) {
              setState(() {
                _selectedPaymentMethod = value;
              });
            },
            visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity,
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          SizedBox(width: 6),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedPaymentMethod = text;
                });
              },
              child: Text(
                text,
                style: const TextStyle(fontSize: 16, height: 2.3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
