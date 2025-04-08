import 'package:flutter/material.dart';
import 'package:medihub_app/core/widgets/appbar.dart';

class NotificationListScreen extends StatefulWidget {
  const NotificationListScreen({super.key});

  @override
  State<NotificationListScreen> createState() => _NotificationListScreenState();
}

class _NotificationListScreenState extends State<NotificationListScreen> {
  int _selectedFilter = 1;

  final Map<int, Widget> _filterContents = {
    1: _buildExaminationFormContent(),
    2: _buildNewsContent(),
    3: _buildNotificationContent(),
  };

  void _showBottomDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        final screenHeight = MediaQuery.of(context).size.height;
        return Container(
          height: screenHeight / 2,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
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
              SizedBox(height: 20),
              _buildDialogButton(
                icon: Icons.visibility_outlined,
                text: "Đánh dấu tất cả đã đọc",
                onPressed: () => Navigator.pop(context),
              ),
              SizedBox(height: 10),
              _buildDialogButton(
                icon: Icons.delete,
                text: "Xoá tất cả thông báo",
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDialogButton({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: onPressed,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade200,
        ),
        child: Row(
          children: [
            Icon(icon, size: 25, color: Colors.black),
            SizedBox(width: 10),
            Text(text, style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        title: 'Danh sách thông báo',
        icon: Icons.more_vert,
        onPressed: () => _showBottomDialog(context),
      ),
      body: Column(
        children: [
          Expanded(flex: 1, child: _buildFilters()),
          Expanded(
            flex: 9,
            child: Center(
              child:
                  _filterContents[_selectedFilter] ??
                  _buildExaminationFormContent(),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildExaminationFormContent() {
    return Column(
      children: [
        SizedBox(height: 20),
        Image.asset("assets/icons/icon_9.png", width: 260, height: 260),
        SizedBox(height: 20),
        Text('Bạn chưa có thông báo nào'),
      ],
    );
  }

  static Widget _buildNewsContent() {
    return Column(
      children: [
        SizedBox(height: 20),
        Image.asset("assets/icons/icon_9.png", width: 260, height: 260),
        SizedBox(height: 20),
        Text('Bạn chưa có thông báo nào'),
      ],
    );
  }

  static Widget _buildNotificationContent() {
    return Column(
      children: [
        SizedBox(height: 20),
        Image.asset("assets/icons/icon_9.png", width: 260, height: 260),
        SizedBox(height: 20),
        Text('Bạn chưa có thông báo nào'),
      ],
    );
  }

  Widget _buildFiltersButton(int key, String title) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        gradient:
            _selectedFilter == key
                ? LinearGradient(
                  colors: [Color(0xFF019BD3), Color(0xA701CBEE)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
                : null,
        color: _selectedFilter != key ? Colors.grey.shade200 : null,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _selectedFilter = key;
          });
        },
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.all(12),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: _selectedFilter == key ? Colors.white : Colors.grey.shade800,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(width: 15),
            _buildFiltersButton(1, 'Phiếu khám (0)'),
            SizedBox(width: 15),
            _buildFiltersButton(2, 'Tin Tức (0)'),
            SizedBox(width: 15),
            _buildFiltersButton(3, 'Thông báo (0)'),
            SizedBox(width: 15),
          ],
        ),
      ),
    );
  }
}
