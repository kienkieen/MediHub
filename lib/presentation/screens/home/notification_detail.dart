import 'package:intl/intl.dart';
import 'package:medihub_app/models/notification_model.dart';
import 'package:flutter/material.dart';

class NotificationDetailScreen extends StatelessWidget {
  final NotificationModel notification;

  const NotificationDetailScreen({super.key, required this.notification});

  Widget _buildHeader() {
    IconData iconData;
    Color iconColor;

    switch (notification.type) {
      case NotificationType.covid:
        iconData = Icons.coronavirus_outlined;
        iconColor = Colors.red;
        break;
      case NotificationType.vaccine:
        iconData = Icons.health_and_safety;
        iconColor = Colors.green;
        break;
      case NotificationType.promotion:
        iconData = Icons.card_giftcard;
        iconColor = Colors.purple;
        break;
      case NotificationType.warning:
        iconData = Icons.warning_amber;
        iconColor = Colors.orange;
        break;
      case NotificationType.general:
      default:
        iconData = Icons.local_hospital;
        iconColor = Colors.blue;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(iconData, size: 50, color: iconColor),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  DateFormat('dd/MM/yyyy HH:mm').format(notification.time),
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chi tiết thông báo',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            const Text(
              'Nội dung',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              notification.detail,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
           
          ],
        ),
      ),
    );
  }
}