import 'package:flutter/material.dart';
import 'package:medihub_app/firebase_helper/firebase_helper.dart';
import 'package:medihub_app/main.dart';
import 'package:medihub_app/models/booking.dart';
import 'package:medihub_app/presentation/screens/home/navigation.dart';
import 'package:medihub_app/presentation/screens/login/login.dart';
import 'package:medihub_app/presentation/screens/services/policy_and_privacy.dart';
import 'package:medihub_app/presentation/screens/services/terms_of_service.dart';
import 'package:medihub_app/presentation/screens/user_account/profile.dart';
import 'package:medihub_app/presentation/screens/user_account/change_password.dart';

class UserAccountScreen extends StatelessWidget {
  const UserAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _AccountHeader(
                userName:
                    userLogin != null ? '${useMainLogin?.fullName}' : 'Khách',
              ),
              if (userLogin != null) ...[
                _Section(
                  title: "Thông tin tài khoản",
                  items: [
                    _MenuItem(
                      icon: Icons.edit,
                      iconColor: Colors.cyan,
                      title: 'Chỉnh sửa tài khoản',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfileScreen(),
                          ),
                        );
                      },
                      showArrow: true,
                    ),
                    _MenuItem(
                      icon: Icons.description_outlined,
                      iconColor: Colors.purple,
                      title: 'Quản lý hồ sơ tiêm chủng',
                      onTap: () {},
                      showArrow: true,
                    ),
                    _MenuItem(
                      icon: Icons.card_giftcard_outlined,
                      iconColor: Colors.green,
                      title: 'Ưu đãi của tôi',
                      onTap: () {},
                      showArrow: true,
                    ),
                    _MenuItem(
                      icon: Icons.help_outline,
                      iconColor: Colors.orange,
                      title: 'Tra cứu điểm thưởng',
                      onTap: () {},
                      showArrow: true,
                    ),
                    _MenuItem(
                      icon: Icons.lock_outline,
                      iconColor: Colors.blue,
                      title: 'Đổi mật khẩu',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChangePasswordScreen(),
                          ),
                        );
                      },
                      showArrow: true,
                    ),
                    _MenuItem(
                      icon: Icons.logout_outlined,
                      iconColor: Colors.red,
                      title: 'Đăng xuất',
                      onTap: () {
                        SignOut();
                        userLogin = null;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    const NavigationBottom(initialIndex: 4),
                          ),
                        );
                      },
                      showArrow: true,
                    ),
                  ],
                ),
              ],

              // Contact Information Header
              _Section(
                title: "Thông tin liên hệ",
                items: [
                  _ContactItem(
                    logoAsset: 'assets/images/logo-vnvc.png',
                    title: 'Tiêm chủng VNVC',
                    phone: '028 7102 6595',
                  ),
                  _ContactItem(
                    logoAsset: 'assets/images/logo-vnvc.png',
                    title: 'Tâm Anh TP HCM',
                    phone: '0287 102 6789',
                  ),
                  _ContactItem(
                    logoAsset: 'assets/images/logo-vnvc.png',
                    title: 'Tâm Anh Hà Nội',
                    phone: '024 3872 3872',
                  ),
                  _ContactItem(
                    logoAsset: 'assets/images/logo-vnvc.png',
                    title: 'Nutrihome',
                    phone: '1900 633 599',
                  ),
                  _ContactItem(
                    logoAsset: 'assets/images/logo-vnvc.png',
                    title: 'Eco Pharma',
                    phone: '1800 556 889',
                  ),
                ],
              ),

              // Policy Information Header
              _Section(
                title: "Thông tin chính sách",
                items: [
                  _MenuItem(
                    icon: Icons.description_outlined,
                    iconColor: Colors.green,
                    title: 'Điều khoản dịch vụ',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => VaccineTermsScreen(
                                booking: Booking(
                                  idUser: '',
                                  idBooking: '',
                                  bookingCenter: '',
                                  dateBooking: DateTime.now(),
                                  totalPrice: 0.0,
                                  lstVaccine: [],
                                ),
                              ),
                        ),
                      );
                    },
                    showArrow: true,
                  ),
                  _MenuItem(
                    icon: Icons.privacy_tip_outlined,
                    iconColor: Colors.blue,
                    title: 'Chính sách quyền riêng tư',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PrivacyPolicyScreen(),
                        ),
                      );
                    },
                    showArrow: true,
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16.0, bottom: 30),
                child: Center(
                  child: Text(
                    'Phiên bản 1.1.2',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The header component for the user account screen
class _AccountHeader extends StatelessWidget {
  final String userName;

  const _AccountHeader({required this.userName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 20, bottom: 30),
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 50, color: Colors.grey),
          ),
          if (useMainLogin != null) ...[
            const SizedBox(height: 15),
            Text(
              "Xin chào",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
          const SizedBox(height: 15),
          Text(
            userName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          if (userLogin == null)
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white, width: 1),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(isNewLoginl: true),
                  ),
                );
              },
              icon: const Icon(
                Icons.login_outlined,
                color: Color.fromARGB(255, 255, 255, 255), // Đổi màu biểu tượng
              ),
              label: const Text('Đăng nhập/Đăng ký'),
            ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String? title;
  final List<Widget> items;

  const _Section({this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200, width: 7),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 10),
              child: _sectionTitle(title!),
            ),
          ...items.asMap().entries.map((entry) {
            final item = entry.value;

            // Add dividers between items
            return Column(children: [item]);
          }).toList(),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}

/// A menu item component for settings and actions
class _MenuItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final VoidCallback onTap;
  final bool showArrow;

  const _MenuItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.onTap,
    this.showArrow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: iconColor.withValues(alpha: 0.2),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(title, style: const TextStyle(fontSize: 15)),
        trailing: showArrow ? const Icon(Icons.chevron_right) : null,
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 2),
      ),
    );
  }
}

/// Contact information item component
class _ContactItem extends StatelessWidget {
  final String logoAsset; // Đường dẫn ảnh
  final String title;
  final String phone;

  const _ContactItem({
    required this.logoAsset,
    required this.title,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
        color: Colors.white,
      ),
      child: Row(
        children: [
          // Hiển thị logo từ ảnh
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4), // Bo góc cho ảnh
              child: Image.asset(
                logoAsset, // Hiển thị ảnh từ đường dẫn
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Thông tin liên hệ
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
          // Số điện thoại với màu xanh
          Text(
            phone,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 0, 10, 146),
            ),
          ),
        ],
      ),
    );
  }
}
