import 'package:flutter/material.dart';
import 'package:medihub_app/core/widgets/appbar.dart';
import 'package:medihub_app/core/widgets/button.dart'; // Sẽ tạo mới

class NotificationListScreen extends StatefulWidget {
  const NotificationListScreen({super.key});

  @override
  State<NotificationListScreen> createState() => _NotificationListScreenState();
}

class _NotificationListScreenState extends State<NotificationListScreen> {
  int _selectedFilter = 1;

  // Danh sách filter để dễ dàng thay đổi
  final List<Map<String, dynamic>> _filters = [
    {'id': 1, 'title': 'Phiếu khám (0)'},
    {'id': 2, 'title': 'Tin Tức (0)'},
    {'id': 3, 'title': 'Thông báo (0)'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        title: 'Danh sách thông báo',
        icon: Icons.more_vert,
        onPressed: () => _showOptionsDialog(context),
      ),
      body: Column(
        children: [
          _buildFilterBar(),
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      height: 70, // Fixed height for filter bar
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        itemCount: _filters.length,
        separatorBuilder: (context, index) => const SizedBox(width: 15),
        itemBuilder: (context, index) {
          final filter = _filters[index];
          return FilterButton(
            title: filter['title'],
            isSelected: _selectedFilter == filter['id'],
            onPressed: () => setState(() => _selectedFilter = filter['id']),
          );
        },
      ),
    );
  }

  Widget _buildContent() {
    // Tất cả các trạng thái hiện có cùng nội dung trống
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        SizedBox(height: 20),
        Image(
          image: AssetImage("assets/icons/icon_9.png"),
          width: 260,
          height: 260,
        ),
        SizedBox(height: 20),
        Text(
          'Bạn chưa có thông báo nào',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  void _showOptionsDialog(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: screenHeight / 2,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.center,
              child: Text(
                "Tuỳ chọn",
                style: TextStyle(
                  color: Color(0xFF007DAB),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildOptionButton(
              icon: Icons.visibility_outlined,
              text: "Đánh dấu tất cả đã đọc",
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(height: 10),
            _buildOptionButton(
              icon: Icons.delete,
              text: "Xoá tất cả thông báo",
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade200,
        ),
        child: Row(
          children: [
            Icon(icon, size: 25, color: Colors.black),
            const SizedBox(width: 10),
            Text(text, style: const TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}