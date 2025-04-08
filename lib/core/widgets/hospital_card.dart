import 'package:flutter/material.dart';

class HospitalCard extends StatelessWidget {
  final String name;
  final String imagePath; // Đường dẫn hình ảnh

  const HospitalCard({super.key, required this.name, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8), // Bo góc cho hình ảnh
            child: Image.asset(
              imagePath, // Đường dẫn hình ảnh
              width: 50, // Chiều rộng hình ảnh
              height: 50, // Chiều cao hình ảnh
              fit: BoxFit.cover, // Đảm bảo hình ảnh vừa khung
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// HospitalCardDetail widget MedicalFacilitiesSection
class HospitalCardDetail extends StatelessWidget {
  final String name;
  final String address;
  final double rating;
  final int ratingCount;
  final String imagePath;

  const HospitalCardDetail({
    Key? key,
    required this.name,
    required this.address,
    required this.rating,
    required this.ratingCount,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      margin: const EdgeInsets.only(right: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section with fixed height
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: SizedBox(
              height: 70,
              width: double.infinity,
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),
          
          // Content section with fixed heights
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Fixed height for hospital name
                SizedBox(
                  height: 36, // Height for 2 lines of text
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Color(0xFF333333),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                
                const SizedBox(height: 4),
                
                // Fixed height for address
                SizedBox(
                  height: 30, // Height for 2 lines of text
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 12,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        child: Text(
                          address,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // Rating row with fixed position
                Row(
                  children: [
                    // Hiển thị số lượng sao dựa trên rating
                    ...List.generate(
                      rating.floor(), // Số lượng sao đầy đủ
                      (index) => const Icon(
                        Icons.star,
                        size: 12,
                        color: Colors.amber,
                      ),
                    ),
                    // Hiển thị sao nửa nếu rating không phải số nguyên
                    if (rating - rating.floor() > 0)
                      const Icon(
                        Icons.star_half,
                        size: 12,
                        color: Colors.amber,
                      ),
                    const SizedBox(width: 4),
                    Text(
                      rating.toStringAsFixed(1), // Hiển thị rating với 1 chữ số thập phân
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '($ratingCount)',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Button section with fixed position
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: SizedBox(
              width: double.infinity,
              height: 30,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00BFFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: EdgeInsets.zero,
                  elevation: 0,
                ),
                child: const Text(
                  'Đặt khám ngay',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
