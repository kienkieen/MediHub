import 'package:flutter/material.dart';
import 'package:medihub_app/presentation/screens/home/event_screen.dart';
import 'package:medihub_app/presentation/screens/home/home.dart';
import 'package:medihub_app/presentation/screens/home/medicalnote.dart';
import 'package:medihub_app/presentation/screens/home/notification.dart';
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
    EventsScreen(), // Sự kiện
    MedicalExaminationFormScreen(), // Phiếu khám
    NotificationScreen(), // Thông báo
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
          NavigationItem(
            iconPath: "assets/icons/navigation/home.png",
            label: "Trang chủ",
          ),
          NavigationItem(
            iconPath: "assets/icons/navigation/date.png",
            label: "Sự kiện",
          ),
          NavigationItem(
            iconPath: "assets/icons/navigation/calendar.png",
            label: "Lịch tiêm",
          ),
          NavigationItem(
            iconPath: "assets/icons/navigation/notification.png",
            label: "Thông báo",
          ),
          NavigationItem(
            iconPath: "assets/icons/navigation/user.png",
            label: "Tài khoản",
          ),
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
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:
              widget.items.asMap().entries.map((entry) {
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
              color:
                  isSelected
                      ? const Color.fromARGB(255, 0, 10, 146)
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 6), // Khoảng cách giữa gạch và icon
          // Icon
          Image.asset(
            iconPath,
            height: 24,
            width: 24,
            color:
                isSelected
                    ? const Color.fromARGB(255, 0, 10, 146)
                    : const Color.fromARGB(255, 41, 41, 41),
          ),
          const SizedBox(height: 4),
          // Label
          Text(
            label,
            style: TextStyle(
              color:
                  isSelected
                      ? const Color.fromARGB(255, 0, 10, 146)
                      : Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.w500,
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

  const NavigationItem({required this.iconPath, required this.label});
}
