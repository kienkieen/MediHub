import 'package:flutter/material.dart';
import 'package:medihub_app/models/event.dart';

class EventDetailsScreen extends StatelessWidget {
  final EventModel event;

  const EventDetailsScreen({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text(
        'Chi tiết sự kiện',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),       
      backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Image with Error Handling
            Image.asset(
              event.imageUrl,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: double.infinity,
                  height: 250,
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.event,
                    color: Colors.blue,
                    size: 100,
                  ),
                );
              },
            ),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    event.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Additional Event Details
                  _buildSectionTitle('Thông tin chi tiết'),
                  const SizedBox(height: 12),
                  _buildDetailRow(Icons.calendar_today, 'Ngày diễn ra', 'Đang cập nhật'),
                  _buildDetailRow(Icons.location_on, 'Địa điểm', 'Đang cập nhật'),
                  _buildDetailRow(Icons.people, 'Đối tác', _getPartners(event.id)),
                  
                  const SizedBox(height: 24),
                  _buildSectionTitle('Mục tiêu sự kiện'),
                  const SizedBox(height: 12),
                  _buildBulletPoints([
                    'Tăng cường hợp tác chiến lược',
                    'Phát triển các giải pháp y tế tiên tiến',
                    'Nâng cao chất lượng dịch vụ chăm sóc sức khỏe'
                  ]),
                  
                  const SizedBox(height: 24),
                  _buildSectionTitle('Người tham dự'),
                  const SizedBox(height: 12),
                  _buildBulletPoints([
                    'Lãnh đạo các tổ chức',
                    'Chuyên gia y tế',
                    'Đại diện doanh nghiệp'
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to get partners based on event ID
  String _getPartners(String eventId) {
    switch (eventId) {
      case '1':
        return 'VNVC và Quỹ Đầu tư Trực tiếp Nga';
      case '2':
        return 'VNVC và Tập đoàn Dược phẩm GSK';
      case '3':
        return 'Bệnh viện Nhi Trung ương, BVDK Tâm Anh và VNVC';
      default:
        return 'Đang cập nhật';
    }
  }

  // Widget to create section titles
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.blue[700],
      ),
    );
  }

  // Widget to create detail rows
  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blue[700], size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget to create bullet point lists
  Widget _buildBulletPoints(List<String> points) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: points.map((point) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 6.0, right: 8.0),
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.blue[700],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  point,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[800],
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class ActivityDetailsScreen extends StatelessWidget {
  final ActivityModel activity;

  const ActivityDetailsScreen({Key? key, required this.activity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chi tiết hoạt động',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                activity.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              
              // Location and Date Details
              _buildDetailRow(
                Icons.location_on, 
                'Địa điểm', 
                activity.location
              ),
              const SizedBox(height: 8),
              _buildDetailRow(
                Icons.calendar_today, 
                'Ngày diễn ra', 
                '${activity.dateTime.day}/${activity.dateTime.month}/${activity.dateTime.year}'
              ),
              
              const SizedBox(height: 24),
              
              // Activity Purpose
              _buildSectionTitle('Mục tiêu hoạt động'),
              const SizedBox(height: 12),
              _buildBulletPoints([
                'Cung cấp kiến thức chuyên sâu về thai sản',
                'Hỗ trợ và tư vấn sức khỏe cho thai phụ',
                'Chia sẻ các phương pháp chăm sóc thai kỳ'
              ]),
              
              const SizedBox(height: 24),
              
              // Expected Participants
              _buildSectionTitle('Đối tượng tham dự'),
              const SizedBox(height: 12),
              _buildBulletPoints([
                'Thai phụ',
                'Gia đình thai phụ',
                'Nhân viên y tế'
              ]),
              
              const SizedBox(height: 24),
              
              // Additional Information
              _buildSectionTitle('Thông tin bổ sung'),
              const SizedBox(height: 12),
              Text(
                'Để đăng ký tham dự hoặc có thêm thông tin chi tiết, vui lòng liên hệ với trung tâm VNVC gần nhất.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[800],
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reuse the helper methods from EventDetailsScreen
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.blue[700],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blue[700], size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoints(List<String> points) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: points.map((point) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 6.0, right: 8.0),
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.blue[700],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  point,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[800],
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}