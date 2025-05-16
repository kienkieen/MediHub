import 'package:flutter/material.dart';
import 'package:medihub_app/core/widgets/notification_item.dart';
import 'package:medihub_app/models/notification_model.dart';
import 'package:medihub_app/presentation/screens/home/navigation.dart';
import 'package:medihub_app/presentation/screens/home/notification_detail.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationProvider _notificationProvider = NotificationProvider();
  bool _isRefreshing = false;

  Future<void> _refreshNotifications() async {
    setState(() {
      _isRefreshing = true;
    });

    // Giả lập việc tải thông báo mới
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isRefreshing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Thông báo",
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
        centerTitle: true,

        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace, size: 28, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Badge(
              label: Text('${_notificationProvider.unreadCount}'),
              isLabelVisible: _notificationProvider.unreadCount > 0,
              child: const Icon(Icons.more_vert, color: Colors.white),
            ),
            onPressed: () {
              // Hiển thị dialog xác nhận đánh dấu tất cả là đã đọc
              if (_notificationProvider.unreadCount > 0) {
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: const Text('Đánh dấu tất cả đã đọc'),
                        content: const Text(
                          'Bạn có muốn đánh dấu tất cả thông báo là đã đọc không?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Hủy'),
                          ),
                          TextButton(
                            onPressed: () {
                              _notificationProvider.markAllAsRead();
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Đã đánh dấu tất cả thông báo là đã đọc',
                                  ),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                            child: const Text('Đồng ý'),
                          ),
                        ],
                      ),
                );
              }
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshNotifications,
        child:
            _isRefreshing
                ? const Center(child: CircularProgressIndicator())
                : _notificationProvider.notifications.isEmpty
                ? const Center(child: Text('Không có thông báo nào'))
                : ListView.builder(
                  itemCount: _notificationProvider.notifications.length,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemBuilder: (context, index) {
                    final notification =
                        _notificationProvider.notifications[index];
                    return NotificationItem(
                      notification: notification,
                      onTap: () {
                        _notificationProvider.markAsRead(notification.id);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => NotificationDetailScreen(
                                  notification: notification,
                                ),
                          ),
                        );
                      },
                    );
                  },
                ),
      ),
    );
  }
}
