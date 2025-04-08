import 'package:flutter/material.dart';
import 'package:medihub_app/presentation/screens/login.dart';

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
              const _AccountHeader(
                userName: 'Khách',
              ),

              // Section: Terms and Regulations
              _Section(
                title: "Điều khoản và quy định",
                items: [
                  _MenuItem(
                    icon: Icons.verified_user,
                    color: Colors.cyan,
                    title: 'Quy định sử dụng',
                    onTap: () {},
                  ),
                  _MenuItem(
                    icon: Icons.lock,
                    color: Colors.purple,
                    title: 'Chính sách bảo mật',
                    onTap: () {},
                  ),
                  _MenuItem(
                    icon: Icons.description,
                    color: Colors.orange,
                    title: 'Điều khoản dịch vụ',
                    onTap: () {},
                  ),
                ],
              ),

              // Customer Support Item
              _MenuItem(
                icon: Icons.phone,
                color: Colors.blue,
                title: 'Tổng dài CSKH 19002115',
                hasBorder: true,
                onTap: () {},
              ),

              // Section: App Feedback
              _Section(
                items: [
                  _MenuItem(
                    icon: Icons.star,
                    color: Colors.yellow.shade800,
                    title: 'Đánh giá ứng dụng',
                    onTap: () {},
                  ),
                  _MenuItem(
                    icon: Icons.share,
                    color: Colors.purpleAccent,
                    title: 'Chia sẻ ứng dụng',
                    onTap: () {},
                  ),
                ],
              ),

              // Bottom items
              _MenuItem(
                icon: Icons.help_outline,
                color: Colors.red,
                title: 'Một số câu hỏi thường gặp',
                hasBorder: true,
                onTap: () {},
              ),
              _MenuItem(
                icon: Icons.g_translate_outlined,
                color: Colors.blue,
                title: 'Ngôn ngữ',
                hasBorder: true,
                onTap: () {},
              ),
              _MenuItem(
                icon: Icons.logout_outlined,
                color: Colors.red,
                title: 'Đăng xuất',
                hasBorder: true,
                onTap: () {},
              ),

              const _Footer(),
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
  
  const _AccountHeader({
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 20, bottom: 30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
              Colors.blueAccent,      // Màu trắng ở dưới
              Colors.lightBlueAccent,      // Màu trắng ở giữa
            ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
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
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.white, width: 2),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(), // Điều hướng đến màn hình Đăng nhập/Đăng ký
                ),
              );
            },
            icon: const Icon(Icons.login_outlined), // Thay đổi biểu tượng thành Đăng nhập
            label: const Text('Đăng nhập/Đăng ký'), // Thay đổi nhãn
          ),
        ],
      ),
    );
  }
}

/// A section component that groups related menu items
class _Section extends StatelessWidget {
  final String? title;
  final List<Widget> items;

  const _Section({
    this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 10),
              child: _sectionTitle(title!),
            ),
          ...items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            
            // Add dividers between items
            return Column(
              children: [
                item,
                if (index < items.length - 1) 
                  const Divider(height: 2),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 5),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16, 
          fontWeight: FontWeight.bold,
          color: Color(0xFF007DAB),
        ),
      ),
    );
  }
}

/// A menu item component for settings and actions
class _MenuItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final VoidCallback onTap;
  final bool hasBorder;

  const _MenuItem({
    required this.icon,
    required this.color,
    required this.title,
    required this.onTap,
    this.hasBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: hasBorder 
          ? const EdgeInsets.symmetric(horizontal: 10)
          : EdgeInsets.zero,
      decoration: BoxDecoration(
        border: Border(
          top: hasBorder 
              ? BorderSide(color: Colors.grey.shade300, width: 1)
              : BorderSide.none,
          bottom: hasBorder 
              ? BorderSide(color: Colors.grey.shade300, width: 1)
              : BorderSide.none,
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}

/// The footer component with company information
class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: const Border(
          top: BorderSide(color: Colors.blueAccent, width: 2), // Viền nổi bật
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo + Info
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blueAccent, width: 1),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8),
                child: CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.transparent,
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: 48,
                    height: 48,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              const SizedBox(width: 20),

              // Text info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '📍 Địa chỉ: 140 Lê Trọng Tấn, quận Tân Phú, TP.HCM',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 6),
                    Text(
                      '🌐 Website: https://tenwebsite.vn',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 6),
                    Text(
                      '📞 Số điện thoại: 0382 431 345',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  const Color(0xFF019BD3).withOpacity(0.5),
                  const Color(0xFF019BD3).withOpacity(0.5),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.2, 0.8, 1.0],
              ),
            ),
          ),          const SizedBox(height: 10),

          // Logo bộ công thương v.v.
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 20,
            runSpacing: 10,
            children: [
              Image.asset('assets/images/bocongthuong.webp', height: 40),
              Image.asset('assets/images/dadangky.webp', height: 40),
            ],
          ),

          const SizedBox(height: 12),

          // Copyright
          const Center(
            child: Text(
              '© 2025 MediHub. All rights reserved.',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}
