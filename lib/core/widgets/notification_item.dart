import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medihub_app/models/notification_model.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onTap;

  const NotificationItem({
    super.key,
    required this.notification,
    required this.onTap,
  });

  // Lấy biểu tượng tương ứng với loại thông báo
  Icon _getNotificationIcon() {
    switch (notification.type) {
      case NotificationType.covid:
        return const Icon(
          Icons.coronavirus_outlined,
          color: Colors.red,
          size: 40,
        );
      case NotificationType.vaccine:
        return const Icon(
          Icons.health_and_safety,
          color: Colors.green,
          size: 40,
        );
      case NotificationType.promotion:
        return const Icon(
          Icons.card_giftcard,
          color: Colors.purple,
          size: 40,
        );
      case NotificationType.warning:
        return const Icon(
          Icons.warning_amber,
          color: Colors.orange,
          size: 40,
        );
      case NotificationType.general:
      default:
        return const Icon(
          Icons.local_hospital,
          color: Colors.blue,
          size: 40,
        );
    }
  }

  // Định dạng thời gian
  String _formatTime() {
    final now = DateTime.now();
    final difference = now.difference(notification.time);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} phút trước';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} giờ trước';
    } else {
      return DateFormat('dd/MM/yyyy HH:mm').format(notification.time);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: notification.isRead ? Colors.white : Colors.lightBlue[50],
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center, // Thay đổi từ start sang center
            children: [
              Container(
                alignment: Alignment.center, // Thêm alignment cho container chứa icon
                child: _getNotificationIcon(),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification.description,
                      style: const TextStyle(fontSize: 12),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatTime(),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              if (!notification.isRead)
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}