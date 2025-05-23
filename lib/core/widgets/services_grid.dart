// File: screens/home/widgets/services_grid.dart
import 'package:flutter/material.dart';
import 'package:medihub_app/presentation/screens/services/vaccination_process.dart';
import 'package:medihub_app/presentation/screens/services/vaccine_list.dart';
import 'package:medihub_app/presentation/screens/services/vaccine_for_u.dart';
import 'package:medihub_app/presentation/screens/services/vaccine_package.dart';
import 'package:medihub_app/presentation/screens/services/appointment.dart';
import 'package:medihub_app/presentation/screens/services/feedback.dart';

class ServicesGrid extends StatelessWidget {
  const ServicesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> topServices = [
      {
        'iconPath': 'assets/icons/grid_service/calendar.png',
        'label': 'Đặt lịch\nhẹn',
        'onPressed': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) =>
                      const AppointmentScreen(), // Điều hướng đến màn hình cụ thể
            ),
          );
        },
      },
      {
        'iconPath': 'assets/icons/grid_service/buy_vaccine.png',
        'label': 'Các\ngói tiêm',
        'onPressed': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const VaccinePackageScreen(),
            ),
          );
        },
      },
      {
        'iconPath': 'assets/icons/grid_service/comments.png',
        'label': 'Góp ý\nphản hồi',
        'onPressed': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) =>
                      const FeedbackForm(), // Điều hướng đến màn hình cụ thể
            ),
          );
        },
      },
      {
        'iconPath': 'assets/icons/grid_service/history.png',
        'label': 'Lịch sử\ntiêm chủng',
        'onPressed': () {},
      },
    ];

    final List<Map<String, dynamic>> bottomServices = [
      {
        'iconPath': 'assets/icons/grid_service/category.png',
        'label': 'Danh mục\nVắc xin',
        'onPressed': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const VaccineListScreen()),
          );
        },
      },
      {
        'iconPath': 'assets/icons/grid_service/age.png',
        'label': 'Vắc xin\ncho bạn',
        'onPressed': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const VaccineForYouScreen(),
            ),
          );
        },
      },
      {
        'iconPath': 'assets/icons/grid_service/procedure.png',
        'label': 'Quy\ntrình tiêm',
        'onPressed': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const VaccinationProcessScreen(),
            ),
          );
        },
      },

      {
        'iconPath': 'assets/icons/grid_service/news.png',
        'label': 'Tin tức\nVắc xin',
        'onPressed': () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const NewsHomeScreen(),
          //   ),
          // );
        },
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
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
        mainAxisExtent: 107,
      ),
      shrinkWrap: true,

      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: service['onPressed'],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withValues(alpha: 0.05),
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
                  width: 80,
                  child: Text(
                    service['label'],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
