import 'package:flutter/material.dart';
class NotificationModel {
  final String id;
  final String title;
  final String description;
  final DateTime time;
  final String detail;
  final bool isRead;
  final NotificationType type;

  NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.detail,
    this.isRead = false,
    this.type = NotificationType.general,
  });

  // Tạo một bản sao của NotificationModel với trạng thái đọc đã cập nhật
  NotificationModel copyWith({bool? isRead}) {
    return NotificationModel(
      id: id,
      title: title,
      description: description,
      time: time,
      detail: detail,
      isRead: isRead ?? this.isRead,
      type: type,
    );
  }
}

// Loại thông báo để hiển thị biểu tượng phù hợp
enum NotificationType {
  covid,
  vaccine,
  promotion,
  warning,
  general,
}

// Provider cho quản lý thông báo
class NotificationProvider extends ChangeNotifier {
  final List<NotificationModel> _notifications = [
    NotificationModel(
      id: '1',
      title: 'COVID-19 TĂNG TRỞ LẠI!',
      description: 'Việt Nam ghi nhận số ca COVID tăng, làm gia tăng nguy cơ đợt nhiễm mới, phế cầu, đạm giá tăng nguy hiểm.',
      time: DateTime.now().subtract(const Duration(hours: 2)),
      detail: 'Việt Nam ghi nhận số ca nhiễm COVID-19 tăng trở lại trong những tuần gần đây, làm gia tăng nguy cơ bùng phát một đợt dịch mới. Các chuyên gia y tế khuyến cáo người dân cần nâng cao ý thức phòng ngừa, đặc biệt là trong bối cảnh các bệnh liên quan đến phế cầu và đạm giá cũng đang có dấu hiệu gia tăng, gây nguy hiểm cho sức khỏe cộng đồng. Hãy đảm bảo tiêm phòng đầy đủ và tuân thủ các biện pháp phòng chống dịch bệnh.',
      type: NotificationType.covid,
    ),
    NotificationModel(
      id: '2',
      title: 'CĂN THẬN BỆNH DẠI DO CHÓ CẮN',
      description: 'Mùa nắng nóng, ca nhiễm gia tăng do số bệnh dại do chó mèo cắn cần chú ý. Tiêm vắc xin dại và tiêm phòng sớm!',
      time: DateTime(2025, 5, 15, 11, 53),
      detail: 'Trong mùa nắng nóng, số ca nhiễm bệnh dại do chó và mèo cắn đã gia tăng đáng kể tại nhiều địa phương. Bệnh dại là một căn bệnh nguy hiểm, có tỷ lệ tử vong cao nếu không được xử lý kịp thời. VNVC khuyến cáo người dân cần tiêm vắc xin dại ngay sau khi bị động vật cắn và thực hiện tiêm phòng sớm để bảo vệ sức khỏe. Nếu có bất kỳ dấu hiệu bất thường nào, hãy đến ngay trung tâm y tế gần nhất để được hỗ trợ.',
      type: NotificationType.warning,
    ),
    NotificationModel(
      id: '3',
      title: 'MIỄN PHÍ TIÊM LAO CHO TRẺ',
      description: 'VNVC miễn phí tiêm vắc xin Lao BCG cho trẻ dưới 1 tuổi tại tất cả trung tâm toàn quốc. Đến tiêm ngay!',
      time: DateTime(2025, 5, 14, 11, 43),
      detail: 'VNVC triển khai chương trình miễn phí tiêm vắc xin Lao BCG dành cho trẻ dưới 1 tuổi tại tất cả các trung tâm trên toàn quốc. Đây là cơ hội để bảo vệ con bạn khỏi bệnh lao – một căn bệnh nguy hiểm có thể gây ảnh hưởng nghiêm trọng đến sức khỏe. Hãy đưa trẻ đến trung tâm VNVC gần nhất để được tiêm phòng ngay hôm nay! Chương trình áp dụng từ ngày 14/05/2025 đến khi có thông báo mới.',
      type: NotificationType.vaccine,
    ),
    NotificationModel(
      id: '4',
      title: 'MIỀN NAM TĂNG NHIỄM NÃO MÔ CẦU',
      description: 'Cảnh báo dịch não mô cầu xuất hiện ở miền nam, đây là bệnh nguy hiểm cần phòng ngừa.',
      time: DateTime(2025, 5, 13, 12, 44),
      detail: 'Khu vực miền Nam Việt Nam đang ghi nhận sự gia tăng các ca nhiễm não mô cầu – một căn bệnh nguy hiểm có thể gây tử vong hoặc để lại di chứng nặng nề nếu không được điều trị kịp thời. VNVC khuyến cáo người dân cần thực hiện các biện pháp phòng ngừa, bao gồm tiêm vắc xin não mô cầu và giữ vệ sinh cá nhân. Hãy đến ngay các trung tâm VNVC để được tư vấn và tiêm phòng, bảo vệ sức khỏe cho bạn và gia đình.',
      type: NotificationType.warning,
    ),
    NotificationModel(
      id: '5',
      title: 'ƯU ĐÃI THÁNG 5',
      description: 'Trong tháng 5, VNVC ưu đãi nhiều vắc xin quan trọng & quà tặng hấp dẫn. Tiêm ngay, phòng bệnh sớm!',
      time: DateTime(2025, 5, 12, 20, 19),
      detail: 'Trong tháng 5, VNVC triển khai chương trình ưu đãi đặc biệt với nhiều loại vắc xin quan trọng và quà tặng hấp dẫn dành cho khách hàng. Đây là cơ hội để bạn và gia đình tiêm phòng các bệnh nguy hiểm với chi phí tiết kiệm. Chương trình bao gồm giảm giá vắc xin và tặng quà cho khách hàng đăng ký tiêm trong tháng. Hãy đến ngay trung tâm VNVC gần nhất để được tư vấn và tham gia chương trình, đảm bảo sức khỏe cho bạn và người thân!',
      type: NotificationType.promotion,
    ),
    NotificationModel(
      id: '6',
      title: 'KÝ VỌNG VỀ VẮC XIN UNG THƯ!',
      description: 'VNVC vừa ký văn kiện hợp tác tại Nga, nỗ lực sớm tiếp cận và đưa vắc xin ung thư tiên tiến về Việt Nam.',
      time: DateTime(2025, 5, 11, 19, 53),
      detail: 'VNVC vừa ký kết văn kiện hợp tác quan trọng tại Nga, đánh dấu bước tiến lớn trong nỗ lực nghiên cứu và đưa vắc xin ung thư tiên tiến về Việt Nam. Đây là một bước ngoặt trong lĩnh vực y tế, mang lại hy vọng mới cho việc phòng ngừa ung thư tại Việt Nam. VNVC cam kết sẽ sớm triển khai các chương trình tiếp cận vắc xin này, giúp người dân có thêm giải pháp bảo vệ sức khỏe trước căn bệnh nguy hiểm này. Hãy theo dõi thông tin từ VNVC để cập nhật tiến độ!',
      type: NotificationType.general,
    ),
    
  ];

  List<NotificationModel> get notifications => _notifications;

  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  void markAsRead(String id) {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
      notifyListeners();
    }
  }

  void markAllAsRead() {
    for (int i = 0; i < _notifications.length; i++) {
      _notifications[i] = _notifications[i].copyWith(isRead: true);
    }
    notifyListeners();
  }
}
