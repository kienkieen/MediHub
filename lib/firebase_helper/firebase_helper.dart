import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> signUpWithGoogle() async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return; // Người dùng hủy

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Đăng nhập với thông tin Google
    final userCredential = await FirebaseAuth.instance.signInWithCredential(
      credential,
    );
    final user = userCredential.user;

    if (user != null) {
      final userDoc = FirebaseFirestore.instance
          .collection('THONGTIN_NGUOIDUNG')
          .doc(user.uid);

      final docSnapshot = await userDoc.get();

      // Nếu chưa tồn tại, nghĩa là đăng ký lần đầu
      if (!docSnapshot.exists) {
        await userDoc.set({
          'hoten': user.displayName,
          'email': user.email,
          'ngaytao': FieldValue.serverTimestamp(),
          'sdt': '',
          'diachi': '',
        });
        print("Tạo mới thông tin người dùng thành công!");
      } else {
        print("Người dùng đã đăng ký trước đó.");
      }
    }
  } catch (e) {
    print("Lỗi khi đăng ký bằng Google: $e");
  }
}

Future<UserCredential?> signInWithGoogle() async {
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  if (googleUser == null) return null;

  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  final userCredential = await FirebaseAuth.instance.signInWithCredential(
    credential,
  );
  final user = userCredential.user;

  // Lưu thông tin vào Firestore nếu chưa có
  if (user != null) {
    final userDoc = FirebaseFirestore.instance
        .collection('THONGTIN_NGUOIDUNG')
        .doc(user.uid);
    final snapshot = await userDoc.get();

    if (!snapshot.exists) {
      await userDoc.set({
        'hoten': user.displayName,
        'email': user.email,
        'sdt': '',
        'diachi': '',
        'ngaytao': FieldValue.serverTimestamp(),
      });
    }
  }

  return userCredential;
}
