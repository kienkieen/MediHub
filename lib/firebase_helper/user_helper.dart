import 'package:medihub_app/models/userMain.dart';
import 'package:medihub_app/firebase_helper/firebase_helper.dart';

Future<UserMain> getUserMain(String userId) async {
  final userDoc = await getData("THONGTIN_NGUOIDUNG", userId);
  if (userDoc != null) {
    return UserMain.fromMap(userDoc);
  } else {
    throw Exception('User not found');
  }
}
