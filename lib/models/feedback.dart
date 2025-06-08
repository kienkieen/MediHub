import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class FeedBack {
  final String id;            // ID của phản hồi (tự động sinh ngẫu nhiên 5 ký tự)
  final String idUser;        // ID của người dùng
  final String? facility;      // Cơ sở
  final int? satisfactionRating; // Mức độ hài lòng
  final String? referralSource; // Biết VNVC qua đâu
  final String? willContinueUsing; // Có tiếp tục sử dụng
  final String? willRecommend;     // Có sẵn lòng giới thiệu
  final String? additionalFeedback; // Ý kiến bổ sung
  final Map<String, String> serviceComments; // Ý kiến dịch vụ
  final Map<String, int> serviceRatings;     // Rating cho dịch vụ
  final DateTime? submissionDate; // Ngày gửi (tự động thêm khi lưu)

  FeedBack({
    required this.id,
    required this.idUser,
    required this.facility,
    required this.satisfactionRating,
    required this.referralSource,
    required this.willContinueUsing,
    required this.willRecommend,
    this.additionalFeedback = '',
    required this.serviceComments,
    required this.serviceRatings,
    this.submissionDate,
  }); // Tự động sinh ID nếu không được cung cấp


  // Chuyển đổi Feedback thành Map để lưu vào Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idUser': idUser,
      'facility': facility,
      'satisfactionRating': satisfactionRating,
      'referralSource': referralSource,
      'willContinueUsing': willContinueUsing,
      'willRecommend': willRecommend,
      'additionalFeedback': additionalFeedback,
      'serviceComments': serviceComments,
      'serviceRatings': serviceRatings,
      'submissionDate': submissionDate ?? FieldValue.serverTimestamp(),
    };
  }

  // Tạo Feedback từ Map (khi lấy dữ liệu từ Firestore)
  factory FeedBack.fromMap(Map<String, dynamic> map) {
    return FeedBack(
      id: map['id'] as String,
      idUser: map['idUser'] as String,
      facility: map['facility'] as String,
      satisfactionRating: map['satisfactionRating'] as int?,
      referralSource: map['referralSource'] as String?,
      willContinueUsing: map['willContinueUsing'] as String?,
      willRecommend: map['willRecommend'] as String?,
      additionalFeedback: map['additionalFeedback'] as String? ?? '',
      serviceComments: Map<String, String>.from(map['serviceComments'] ?? {}),
      serviceRatings: Map<String, int>.from(map['serviceRatings'] ?? {}),
      submissionDate: map['submissionDate'] != null
          ? (map['submissionDate'] as Timestamp).toDate()
          : null,
    );
  }
}