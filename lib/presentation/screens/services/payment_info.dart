import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medihub_app/api/APIQRequest.dart';
import 'package:medihub_app/api/APIService.dart';
import 'package:medihub_app/core/widgets/login_widgets/button.dart';
import 'package:medihub_app/core/widgets/appbar.dart';
import 'package:medihub_app/firebase_helper/firebase_helper.dart';
import 'package:medihub_app/models/bill.dart';
import 'package:medihub_app/models/booking.dart';
import 'package:medihub_app/presentation/screens/home/navigation.dart';
import 'dart:convert';

import 'package:medihub_app/presentation/screens/services/appointment.dart';

class PaymentInfoScreen extends StatefulWidget {
  final Booking booking;
  final String paymentMethod;
  const PaymentInfoScreen({
    super.key,
    required this.booking,
    required this.paymentMethod,
  });

  State<PaymentInfoScreen> createState() => _PaymentInfoScreenState();
}

class _PaymentInfoScreenState extends State<PaymentInfoScreen> {
  late String orderId = '';
  final String accountNumber = "19132680330012";
  final String accountHolder = "Công ty cổ phần vắc xin Việt Nam - CN TPHCM";
  final String bank = "Techcombank - CN Thắng Lợi, Tp.HCM";
  final String qrCodeNote = "QR Pay 10YRKJqV5";
  late double totalAmount = 0;
  final apiService = APIService();
  Image? qrImage;
  String generateRandomString(int length) {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final rand = Random.secure(); // dùng Random.secure() để bảo mật hơn
    return List.generate(
      length,
      (index) => chars[rand.nextInt(chars.length)],
    ).join();
  }

  Future<Image> generateQR() async {
    final request = APIRequest(
      accountNo: int.parse(accountNumber),
      accountName: accountHolder,
      acqId: 970436,
      amount: totalAmount,
      addInfo: "THANH TOAN HOA DON TIEM TRUNG VNVC",
      format: "text",
      template: "compact",
    );

    try {
      final response = await apiService.generateQRCode(request);

      String? qrDataUrl = response.data?.qrDataURL;

      if (qrDataUrl != null && qrDataUrl.contains(',')) {
        // Lấy phần base64 thực sự
        final base64Str = qrDataUrl.split(',').last;
        final decodedBytes = base64Decode(base64Str);

        return Image.memory(decodedBytes);
      }
      throw Exception("Không tìm thấy dữ liệu QR Code hợp lệ");
    } catch (e) {
      print("Lỗi: ${e}");
      return Image.asset('assets/images/qr_code.jpg');
    }
  }

  void _setQRImage() async {
    final image = await generateQR();
    setState(() {
      qrImage = image;
    });
  }

  @override
  void initState() {
    totalAmount = widget.booking.totalPrice;
    orderId = generateRandomString(8);
    _setQRImage();
  }

  void _submitbooking() async {
    // Giả lập việc gửi thông tin đặt lịch
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Đang xử lý thanh toán...')));
    bool up = await insertDataAutoID("DATLICHTIEM", widget.booking.toMap());
    if (up) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Thanh toán thành công')));
      Bill bill = Bill(
        id: orderId,
        paymentMethod: widget.paymentMethod,
        totalAmount: totalAmount,
        dueDate: DateTime.now().add(const Duration(days: 30)),
        isPaid: false,
      );
      insertData("HOADON", bill.id, bill.toMap());
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NavigationBottom(initialIndex: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Thanh toán thất bại')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarWidget(isBackButton: true, title: 'Thông tin thanh toán'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Thanh toán đơn hàng ${orderId}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'THÔNG TIN THANH TOÁN',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Ấn dùng cho thanh toán vĩ điện tử & tất cả các cổng hàng trong mạng lưới',
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset('assets/images/momo.jpg', height: 35),
                        Image.asset('assets/images/vietqr.png', height: 25),
                        Image.asset('assets/images/napas.png', height: 23),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child:
                          qrImage != null
                              ? qrImage!
                              : CircularProgressIndicator(),
                    ),
                    const SizedBox(height: 8),
                    const Center(
                      child: Text(
                        '↓ Tải mã',
                        style: TextStyle(fontSize: 14, color: Colors.blue),
                      ),
                    ),
                    const SizedBox(height: 8),

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Số tiền thanh toán:',
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              NumberFormat.currency(
                                locale: 'vi_VN',
                                symbol: 'VND',
                              ).format(totalAmount),
                              style: const TextStyle(
                                fontSize: 17,
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
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: const Text(
                        'THÔNG TIN CHUYỂN KHOẢN',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('STK: $accountNumber'),
                    const SizedBox(height: 6),
                    Text('Chủ TK: $accountHolder'),
                    const SizedBox(height: 6),
                    Text('Ngân hàng: $bank'),
                    const SizedBox(height: 6),
                    Text('Nội dung chuyển: "$qrCodeNote"'),
                    const SizedBox(height: 6),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'HƯỚNG DẪN THANH TOÁN',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '1. Quét mã trực tiếp/ Tải mã/ Chụp lại mã QR',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      '2. Đăng nhập ứng dụng Ngân hàng/Ví điện tử, chọn QR Pay',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      '3. Tải màn hình quét mã QR, chọn chức năng "Thu viện \nánh" và chọn ảnh QR đã tải/chụp, chọn chức năng QR Pay',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      '4. Kiểm tra thông tin chuyển khoản, Quy khách không \nsửa nội dung chuyển khoản',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      '5. Xác nhận và hoàn tất giao dịch',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      '6. Thông tin thanh toán sẽ Quy khách sẽ được cập \nnhật sau vài phút. Chi tiết Liên hệ hotline: 028 7300 6595',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            PrimaryButton(
              text: 'XÁC NHẬN THANH TOÁN',
              borderRadius: 40,
              onPressed: () {
                _submitbooking();
              },
            ),
            const SizedBox(height: 16),
            PrimaryButton(
              text: 'VỀ LẠI TRANG CHỦ',
              borderRadius: 40,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NavigationBottom()),
                );
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
