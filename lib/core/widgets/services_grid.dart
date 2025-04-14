// File: screens/home/widgets/services_grid.dart
import 'package:flutter/material.dart';

class ServicesGrid extends StatelessWidget {
  const ServicesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> topServices = [
      {
        'iconPath': 'assets/icons/grid_service/calendar.png',
        'label': 'Đặt lịch\nhẹn',
      },
      {
        'iconPath': 'assets/icons/grid_service/news.png',
        'label': 'Tin tức\nVắc xin',
      },
      {
        'iconPath': 'assets/icons/grid_service/comments.png',
        'label': 'Góp ý\nphản hồi',
      },
      {
        'iconPath': 'assets/icons/grid_service/history.png',
        'label': 'Lịch sử\ntiêm chủng',
      },
    ];

    final List<Map<String, dynamic>> bottomServices = [
      {
        'iconPath': 'assets/icons/grid_service/category.png',
        'label': 'Danh mục\nVắc xin',
      },
      {
        'iconPath': 'assets/icons/grid_service/buy_vaccine.png',
        'label': 'Vắc xin\ntheo tuổi',
      },
      {
        'iconPath': 'assets/icons/grid_service/reward.png',
        'label': 'Ưu đãi\ncủa tôi',
      },
      {
        'iconPath': 'assets/icons/grid_service/buy_vaccine.png',
        'label': 'Đặt mua\nVắc xin',
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            ServiceRow(services: topServices),
            const SizedBox(height: 16),
            ServiceRow(services: bottomServices),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class ServiceRow extends StatelessWidget {
  final List<Map<String, dynamic>> services;

  const ServiceRow({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children:
          services.map((service) {
            return Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.withValues(
                        alpha: 0.05,
                      ), // Nền nhẹ cho biểu tượng
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(
                      service['iconPath'],
                      width: 32,
                      height: 32,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: 80, // Giới hạn chiều rộng để chữ xuống dòng
                    child: Text(
                      service['label'],
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        height: 1.5, // Tăng khoảng cách giữa các dòng
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2, // Giới hạn 2 dòng
                      overflow: TextOverflow.ellipsis, // Ẩn nếu quá dài
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }
}
