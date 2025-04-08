// File: screens/home/widgets/medical_facilities_section.dart
import 'package:flutter/material.dart';
import 'package:medihub_app/core/widgets/hospital_card.dart';

class MedicalFacilitiesSection extends StatelessWidget {
  const MedicalFacilitiesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min, // Đảm bảo chỉ dùng không gian cần thiết
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'CƠ SỞ Y TẾ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF004466),
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  minimumSize: Size.zero, // Giảm kích thước tối thiểu
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min, // Đảm bảo button chỉ rộng theo nội dung
                  children: [
                    Text(
                      'Xem tất cả',
                      style: TextStyle(color: Color(0xFF0099CC), fontSize: 12),
                    ),
                    SizedBox(width: 2),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: Color(0xFF0099CC),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
          child: Text(
            'đặt khám nhiều nhất',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ),
        SizedBox(
          height: 230, // Giảm chiều cao để phù hợp với các thẻ đã điều chỉnh
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            physics: const BouncingScrollPhysics(), // Thêm physics để có hiệu ứng cuộn mượt
            clipBehavior: Clip.none, // Tránh cắt nội dung khi cuộn
            children: const [
              HospitalCardDetail(
                name: "Bệnh viện Đại học Y Dược TP.HCM",
                address: "Nguyễn Chí Thanh, Q.5, TP.HCM",
                rating: 4.5,
                ratingCount: 93,
                imagePath: "assets/images/image_10.png",
              ),
              HospitalCardDetail(
                name: "Bệnh viện Nhi Đồng 1",
                address: "Quận 10, TP.HCM",
                rating: 4.5,
                ratingCount: 85,
                imagePath: "assets/images/image_11.png",
              ),
              HospitalCardDetail(
                name: "Bệnh viện Nhi Đồng Thành Phố",
                address: "Quận 5, TP.HCM",
                rating: 4.0,
                ratingCount: 120,
                imagePath: "assets/images/image_12.png",
              ),
              HospitalCardDetail(
                name: "Bệnh viện Da Liễu TP.HCM",
                address: "Quận 3, TP.HCM",
                rating: 5.0,
                ratingCount: 70,
                imagePath: "assets/images/image_13.png",
              ),
              HospitalCardDetail(
                name: "Bệnh viện Chấn Thương Chỉnh Hình",
                address: "Quận 5, TP.HCM",
                rating: 4.5,
                ratingCount: 60,
                imagePath: "assets/images/image_14.png",
              ),
              HospitalCardDetail(
                name: "Bệnh viện Mắt TP.HCM",
                address: "Quận 3, TP.HCM",
                rating: 5.0,
                ratingCount: 95,
                imagePath: "assets/images/image_15.png",
              ),
              HospitalCardDetail(
                name: "Bệnh viện Quận Bình Thạnh",
                address: "Quận Bình Thạnh, TP.HCM",
                rating: 4.5,
                ratingCount: 50,
                imagePath: "assets/images/image_16.png",
              ),
            ],
          ),
        ),
      ],
    );
  }
}