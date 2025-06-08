import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medihub_app/models/feedback.dart';

class FeedbackHelper {
  static final FeedbackHelper _instance = FeedbackHelper._internal();
  factory FeedbackHelper() => _instance;
  FeedbackHelper._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'GOPY'; // Tên collection trong Firestore

  // Lưu feedback lên Firestore
  Future<void> saveFeedback(FeedBack feedback) async {
  try {
    await FirebaseFirestore.instance
        .collection('feedbacks') 
        .add(feedback.toMap());
    print('Feedback saved successfully');
  } catch (e) {
    print('Error saving feedback: $e');
 
  }
}

  // Lấy feedback theo email của người dùng
  Future<List<FeedBack>> getFeedbacksByEmail(String email) async {
    try {
      final querySnapshot = await _firestore
          .collection(_collectionName)
          .where('email', isEqualTo: email)
          .get();
      return querySnapshot.docs.map((doc) {
        return FeedBack.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Error fetching feedbacks by email: $e');
      return [];
    }
  }

}