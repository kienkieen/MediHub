import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medihub_app/presentation/screens/home/home.dart';
import 'package:medihub_app/presentation/screens/home/medicalnote.dart';
import 'package:medihub_app/presentation/screens/home/notification.dart';
import 'package:medihub_app/presentation/screens/home/profile.dart';
import 'package:medihub_app/presentation/screens/home/user_account.dart';

class NavigationBottom extends StatefulWidget {
  const NavigationBottom({super.key});

  @override
  State<NavigationBottom> createState() => _NavigationBottomState();
}

class _NavigationBottomState extends State<NavigationBottom> {
  int _selectedIndex = 0; // Theo dõi mục được chọn

  final List<Widget> _pages = [
    HomeScreen(), // Trang chủ
    ProfileScreen(), // Hồ sơ
    MedicalExaminationFormScreen(), // Phiếu khám
    NotificationListScreen(), // Thông báo
    UserAccountScreen(), // Tài khoản
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Cập nhật mục được chọn
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Hiển thị trang tương ứng
      bottomNavigationBar: NavigationBottomBar(
        items: [
          NavigationItem(iconPath: "assets/icons/home.svg", label: "Trang chủ"),
          NavigationItem(iconPath: "assets/icons/date.svg", label: "Sự kiện"),
          NavigationItem(iconPath: "assets/icons/calendar.svg", label: "Lịch tiêm"),
          NavigationItem(iconPath: "assets/icons/chat.svg", label: "Liên hệ"),
          NavigationItem(iconPath: "assets/icons/user.svg", label: "Tài khoản"),
        ],
        initialIndex: _selectedIndex,
        onItemSelected: _onItemTapped,
      ),
    );
  }
}

class NavigationBottomBar extends StatefulWidget {
  final List<NavigationItem> items; // Danh sách các mục trong thanh điều hướng
  final int initialIndex; // Mục được chọn ban đầu
  final ValueChanged<int> onItemSelected; // Hàm callback khi mục được chọn

  const NavigationBottomBar({
    super.key,
    required this.items,
    this.initialIndex = 0,
    required this.onItemSelected,
  });

  @override
  State<NavigationBottomBar> createState() => _NavigationBottomBarState();
}

class _NavigationBottomBarState extends State<NavigationBottomBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex; // Gán mục được chọn ban đầu
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Cập nhật mục được chọn
    });
    widget.onItemSelected(index); // Gọi callback khi mục được chọn
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: widget.items.asMap().entries.map((entry) {
            final int index = entry.key;
            final NavigationItem item = entry.value;
            return _buildNavItem(item.iconPath, item.label, index);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildNavItem(String iconPath, String label, int index) {
    final bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4,
            width: 40,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF0099CC) : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 6), // Khoảng cách giữa gạch và icon
          // Icon
          SvgPicture.asset(
            iconPath,
            height: 24,
            width: 24,
            colorFilter: ColorFilter.mode(
              isSelected ? const Color(0xFF0099CC) : const Color.fromARGB(255, 41, 41, 41),
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 4),
          // Label
          Text(
            label,
            style: TextStyle(
              color: isSelected ? const Color(0xFF0099CC) : const Color.fromARGB(255, 41, 41, 41),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class NavigationItem {
  final String iconPath;
  final String label;

  const NavigationItem({
    required this.iconPath,
    required this.label,
  });
}