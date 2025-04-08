// File: screens/home/widgets/services_grid.dart
import 'package:flutter/material.dart';

class ServicesGrid extends StatelessWidget {
  const ServicesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> topServices = [
      {
        'image': 'assets/icons/icon_4.png',
        'label': 'Đặt khám tại cơ sở',
      },
      {
        'image': 'assets/icons/icon_1.png',
        'label': 'Gọi video với bác sĩ',
      },
      {
        'image': 'assets/icons/icon_6.png',
        'label': 'Đặt khám ngoài giờ',
      },
      {
        'image': 'assets/icons/icon_3.png',
        'label': 'Đặt lịch tiêm chủng',
      },
    ];

    final List<Map<String, dynamic>> bottomServices = [
      {
        'image': 'assets/icons/icon_7.png',
        'label': 'Đặt khám Bác sĩ',
      },
      {
        'image': 'assets/icons/icon_8.png',
        'label': 'Gói sức khỏe toàn diện',
      },
      {
        'image': 'assets/icons/icon_5.png',
        'label': 'Đặt lịch xét nghiệm',
      },
      {
        'image': 'assets/icons/icon_2.png',
        'label': 'Kết quả khám bệnh',
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
              color: Colors.black.withOpacity(0.05),
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

  const ServiceRow({
    super.key,
    required this.services,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: services.map((service) {
        return Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    service['image'],
                    width: 32,
                    height: 32,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: 80, // Giới hạn chiều rộng để chữ xuống dòng
                child: Text(
                  service['label'],
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                  maxLines: 2,
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