import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medihub_app/core/widgets/input_field.dart';
import 'package:medihub_app/core/widgets/appbar.dart';
import 'package:medihub_app/core/widgets/login_widgets/button.dart';
import 'package:medihub_app/presentation/screens/services/payment_info.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final List<Map<String, dynamic>> vaccines = [
    {'name': 'Vắc xin 5 trong 1', 'price': 1500000},
    {'name': 'Vắc xin Sởi', 'price': 500000},
    {'name': 'Vắc xin Cúm', 'price': 300000},
  ];
  String? _selectedPaymentMethod;

  final double total = 3400000;

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
              InputField(label: 'Họ tên', hintText: 'HT', enable: false),
              InputField(
                label: 'Số điện thoại',
                hintText: 'Sdt',
                enable: false,
              ),
              InputField(label: 'Email', hintText: 'Email', enable: false),
              InputField(
                label: 'Trung tâm tiêm',
                hintText: 'Hà Nội',
                enable: false,
              ),
              InputField(
                label: 'Ngày mong muốn tiêm',
                hintText: '20/2/2024',
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
              ...vaccines
                  .map(
                    (vaccine) =>
                        _buildVaccineItem(vaccine['name'], vaccine['price']),
                  )
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
                    ).format(total),
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
                      builder: (context) => PaymentInfoScreen(),
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

  Widget _buildVaccineItem(String name, int price) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: const TextStyle(fontSize: 16)),
          Text(
            NumberFormat.currency(locale: 'vi_VN', symbol: 'VND').format(price),
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
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
