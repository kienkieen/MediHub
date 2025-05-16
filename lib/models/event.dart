import 'package:flutter/material.dart';

class EventModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}

class ActivityModel {
  final String id;
  final String title;
  final String location;
  final DateTime dateTime;

  ActivityModel({
    required this.id,
    required this.title,
    required this.location,
    required this.dateTime,
  });
}

class DataEvent {
  static List<EventModel> getEvents() {
    return [
      EventModel(
        id: '1',
        title: 'Tổng thống Nga Putin và Tổng Bí thư Tô Lâm chứng kiến hợp tác của VNVC và Quỹ Đầu tư Trực tiếp Nga về vắc xin',
        description: 'Chi tiết sự kiện hợp tác giữa VNVC và Quỹ Đầu tư Trực tiếp Nga',
        imageUrl: 'assets/images/event1.webp', // Placeholder for image
      ),
      EventModel(
        id: '2',
        title: 'EPLUS – Đối tác chiến lược toàn diện của VNVC và Tập đoàn Dược phẩm GSK',
        description: 'Thông tin chi tiết về hợp tác chiến lược',
        imageUrl: 'assets/images/event2.webp', // Placeholder for image
      ),
      EventModel(
        id: '3',
        title: 'Bệnh viện Nhi Trung ương ký kết hợp tác với BVDK Tâm Anh và Hệ thống tiêm chủng VNVC',
        description: 'Chi tiết buổi ký kết hợp tác',
        imageUrl: 'assets/images/event3.jpg', // Placeholder for image
      ),
    ];
  }

  static List<ActivityModel> getActivities() {
    return [
      ActivityModel(
        id: '1',
        title: 'Lớp Tư vấn kiến thức Thai Sản số 49 - VNVC Lê Văn Thiêm',
        location: 'VNVC Lê Văn Thiêm',
        dateTime: DateTime(2025, 4, 26),
      ),
      ActivityModel(
        id: '2',
        title: 'Lớp Tư vấn kiến thức Thai Sản tại VNVC Mỹ Thọ',
        location: 'VNVC Mỹ Thọ',
        dateTime: DateTime(2025, 4, 24),
      ),
      ActivityModel(
        id: '3',
        title: 'Lớp Tư vấn kiến thức Thai Sản số 48 - VNVC Phạm Văn Đổng',
        location: 'VNVC Phạm Văn Đổng',
        dateTime: DateTime(2025, 4, 12),
      ),
      ActivityModel(
        id: '4',
        title: 'Lớp Tư vấn kiến thức Thai Sản số 47 - VNVC Mỹ Đình',
        location: 'VNVC Mỹ Đình',
        dateTime: DateTime(2025, 3, 29),
      ),
      ActivityModel(
        id: '5',
        title: 'Lớp Tư vấn kiến thức Thai Sản số 46 - VNVC Icon 4',
        location: 'VNVC Vũng Tàu',
        dateTime: DateTime(2025, 3, 15),
      ),
    ];
  }
}

Widget buildEventList(List<EventModel> events) {
  return ListView.builder(
    itemCount: events.length,
    itemBuilder: (context, index) {
      final event = events[index];
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hiển thị ảnh
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                event.imageUrl, // Đường dẫn ảnh từ EventModel
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover, // Đảm bảo ảnh phủ đầy khung
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    event.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}