import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medihub_app/core/widgets/appbar.dart';

class VaccinationProcessScreen extends StatelessWidget {
  const VaccinationProcessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppbarWidget(title: 'Quy trình tiêm'),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 15),
                HeroSection(),
                SizedBox(height: 15),
                StepsSection(),
                NotesSection(),
                CTASection(),
                FooterSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFF0091FF).withOpacity(0.1),
                borderRadius: BorderRadius.circular(32),
              ),
              child: const Center(
                child: FaIcon(
                  FontAwesomeIcons.hospitalUser,
                  color: Color(0xFF2F8CD8),
                  size: 24,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quy trình tiêm vắc xin',
                    style: TextStyle(
                      color: const Color(0xFF2F8CD8),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Hướng dẫn chi tiết quy trình tiêm chủng tại VNVC',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StepsSection extends StatelessWidget {
  const StepsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = [
      {
        'icon': FontAwesomeIcons.clipboardList,
        'title': 'Bước 1',
        'description': 'Đăng ký thông tin tại quầy lễ tân',
      },
      {
        'icon': FontAwesomeIcons.heartbeat,
        'title': 'Bước 2',
        'description': 'Khám sàng lọc trước tiêm',
      },
      {
        'icon': FontAwesomeIcons.userMd,
        'title': 'Bước 3',
        'description': 'Bác sĩ khám, tư vấn và chỉ định tiêm',
      },
      {
        'icon': FontAwesomeIcons.creditCard,
        'title': 'Bước 4',
        'description': 'Thanh toán',
      },
      {
        'icon': FontAwesomeIcons.syringe,
        'title': 'Bước 5',
        'description': 'Tiêm vắc xin',
      },
      {
        'icon': FontAwesomeIcons.heartPulse,
        'title': 'Bước 6',
        'description': 'Theo dõi sau tiêm trong 30 phút',
      },
      {
        'icon': FontAwesomeIcons.houseMedical,
        'title': 'Bước 7',
        'description':
            'Kiểm tra sức khỏe và hướng dẫn theo dõi sau tiêm tại nhà',
      },
      {
        'icon': FontAwesomeIcons.headset,
        'title': 'Bước 8',
        'description': 'Hỗ trợ, tư vấn Khách hàng về các phản ứng sau tiêm',
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 253, 254, 255),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            spreadRadius: 3,
            blurRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 15),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: const Color(0xFF0091FF), width: 5),
              ),
            ),
            child: Text(
              'Các bước tiêm chủng',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2F8CD8),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ...List.generate(
            steps.length,
            (index) => TimelineStep(
              icon: steps[index]['icon'] as IconData,
              title: steps[index]['title'] as String,
              description: steps[index]['description'] as String,
              isLast: index == steps.length - 1,
            ),
          ),
        ],
      ),
    );
  }
}

class TimelineStep extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool isLast;

  const TimelineStep({
    Key? key,
    required this.icon,
    required this.title,
    required this.description,
    this.isLast = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: const Color(0xFF1976D2),
                borderRadius: BorderRadius.circular(11),
                border: Border.all(color: Colors.white, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1976D2).withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 0,
                  ),
                ],
              ),
            ),
            if (!isLast)
              Container(width: 2, height: 110, color: const Color(0xFFE0E0E0)),
          ],
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(
                    255,
                    12,
                    74,
                    125,
                  ).withValues(alpha: 0.15),
                  spreadRadius: 3,
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
              border: Border(
                left: BorderSide(color: const Color(0xFF1976D2), width: 4),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1976D2).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Center(
                      child: FaIcon(
                        icon,
                        color: const Color(0xFF1976D2),
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            color: const Color(0xFF1976D2),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          description,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class NotesSection extends StatelessWidget {
  const NotesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notes = [
      {
        'icon': FontAwesomeIcons.idCard,
        'text':
            'Mang theo CCCD/hộ chiếu, sổ tiêm chủng và sổ khám bệnh (nếu có).',
      },
      {
        'icon': FontAwesomeIcons.clock,
        'text': 'Theo dõi ít nhất 30 phút sau tiêm tại trung tâm.',
      },
      {
        'icon': FontAwesomeIcons.phoneVolume,
        'text': 'Liên hệ trung tâm nếu có biểu hiện bất thường.',
      },
      {
        'icon': FontAwesomeIcons.calendarCheck,
        'text': 'Tiêm đủ lịch để đảm bảo hiệu quả phòng bệnh.',
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 253, 254, 255),
        borderRadius: BorderRadius.all(Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            spreadRadius: 3,
            blurRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
      ),
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 15),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: const Color(0xFF0091FF), width: 5),
              ),
            ),
            child: Text(
              'Lưu ý quan trọng',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2F8CD8),
              ),
            ),
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                children:
                    notes.map((note) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE3F2FD),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: FaIcon(
                                  note['icon'] as IconData,
                                  color: const Color(0xFF0091FF),
                                  size: 16,
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Text(
                                note['text'] as String,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CTASection extends StatelessWidget {
  const CTASection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0091FF),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Đăng ký tiêm chủng ngay',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFBBDEFB), width: 1),
            ),
            child: const Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.headset,
                  color: Color(0xFF0091FF),
                  size: 22,
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Text(
                    'Cần hỗ trợ?\nLiên hệ hotline: 1900 6538',
                    style: TextStyle(
                      color: Color(0xFF0D47A1),
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FooterSection extends StatelessWidget {
  const FooterSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        border: Border(
          top: BorderSide(color: const Color(0xFFE0E0E0), width: 1),
        ),
      ),
      child: const Center(
        child: Text(
          '© 2025 VNVC - Hệ thống Trung tâm Tiêm chủng Vắc xin lớn nhất Việt Nam',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
