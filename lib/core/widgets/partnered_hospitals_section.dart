// File: screens/home/widgets/partnered_hospitals_section.dart
import 'package:flutter/material.dart';
import 'package:medihub_app/core/widgets/hospital_card.dart';

class PartneredHospitalsSection extends StatefulWidget {
  const PartneredHospitalsSection({super.key});

  @override
  State<PartneredHospitalsSection> createState() =>
      _PartneredHospitalsSectionState();
}

class _PartneredHospitalsSectionState extends State<PartneredHospitalsSection> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "ĐƯỢC TIN TƯỞNG HỢP TÁC VÀ ĐỒNG HÀNH",
            style: TextStyle(
              color: Color(0xFF004466),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 120, // Tăng chiều cao để chứa cả mũi tên
            child: Stack(
              children: [
                // ListView hiển thị các bệnh viện
                ListView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  children: const [
                    HospitalCard(
                      name: "Bệnh viện Đại học Y Dược TP.HCM",
                      imagePath: "assets/images/image_10.png",
                    ),
                    HospitalCard(
                      name: "Bệnh viện Nhi Đồng 1",
                      imagePath: "assets/images/image_11.png",
                    ),
                    HospitalCard(
                      name: "Bệnh viện Chấn Thương Chỉnh Hình",
                      imagePath: "assets/images/image_14.png",
                    ),
                    HospitalCard(
                      name: "Bệnh viện Nhi Đồng Thành Phố",
                      imagePath: "assets/images/image_12.png",
                    ),
                    HospitalCard(
                      name: "Bệnh viện Da Liễu TP.HCM",
                      imagePath: "assets/images/image_13.png",
                    ),
                    HospitalCard(
                      name: "Bệnh viện Mắt TP.HCM",
                      imagePath: "assets/images/image_15.png",
                    ),
                    HospitalCard(
                      name: "Bệnh viện Quận Bình Thạch",
                      imagePath: "assets/images/image_16.png",
                    ),
                  ],
                ),
                // Mũi tên bên trái
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: () {
                      _scrollController.animateTo(
                        _scrollController.offset - 120, // Cuộn sang trái
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Container(
                      width: 40,
                      color: Colors.transparent, // Để dễ nhấn
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xFF0099CC),
                      ),
                    ),
                  ),
                ),
                // Mũi tên bên phải
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: () {
                      _scrollController.animateTo(
                        _scrollController.offset + 120, // Cuộn sang phải
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Container(
                      width: 40,
                      color: Colors.transparent, // Để dễ nhấn
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFF0099CC),
                      ),
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
