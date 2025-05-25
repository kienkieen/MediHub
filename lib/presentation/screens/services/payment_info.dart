import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medihub_app/core/widgets/login_widgets/button.dart';
import 'package:medihub_app/core/widgets/appbar.dart';
import 'package:medihub_app/presentation/screens/home/navigation.dart';

class PaymentInfoScreen extends StatelessWidget {
  const PaymentInfoScreen({super.key});
  final String orderId = "10YRKJqV5";
  final String accountNumber = "19132680330012";
  final String accountHolder = "Công ty cổ phần vắc xin Việt Nam - CN TPHCM";
  final String bank = "Techcombank - CN Thắng Lợi, Tp.HCM";
  final String qrCodeNote = "QR Pay 10YRKJqV5";
  final double totalAmount = 3400000;

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
            const Text(
              'Thanh toán đơn hàng 10YRKJqV5',
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
                      child: Image.asset(
                        'assets/images/qr_code.jpg', // Thay bằng đường dẫn ảnh QR thực tế
                        height: 150,
                      ),
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

void main() {
  runApp(MaterialApp(home: PaymentInfoScreen()));
}
