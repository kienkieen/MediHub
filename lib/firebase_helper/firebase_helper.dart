import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:medihub_app/firebase_helper/user_helper.dart';
import 'package:medihub_app/main.dart';
import 'package:medihub_app/models/cart.dart';
import 'package:medihub_app/models/userMain.dart';

Future<bool> sendEmail(String userEmail, String numberVerify) async {
  String username = 'katerrasky02@gmail.com';
  String password = 'ugax phem ojha wqzw';

  final smtpServer = gmail(username, password);

  final message =
      Message()
        ..from = Address(username, 'VNVC')
        ..recipients.add(userEmail)
        ..subject = 'Mã xác thực của bạn:'
        ..text = 'Chào bạn'
        ..html = "<h1>$numberVerify</h1><p>Cảm ơn bạn đã xác thực</p>";

  try {
    final sendReport = await send(message, smtpServer);
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> signUp(String email, String password, String name) async {
  try {
    UserCredential u = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    User? user = u.user;
    UserMain userMain = UserMain(
      userId: user!.uid,
      fullName: name,
      gender: '',
      job: 'Chưa xác định',
      dateOfBirth: DateTime.now(),
      phoneNumber: '',
      numberBHYT: '',
      email: email,
      city: '',
      district: '',
      ward: '',
      address: '',
      idCardNumber: '',
      ethnicity: '',
      nationality: '',
    );

    if (user != null) {
      insertData("THONGTIN_NGUOIDUNG", userMain.userId, userMain.toMap());
    }
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> SignIn(String email, String password) async {
  try {
    UserCredential u = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    User? user = u.user;
    if (user != null) {
      userLogin = FirebaseAuth.instance.currentUser;
      useMainLogin = await getUserMain(user.uid);
    }
    return true;
  } catch (e) {
    return false;
  }
}

Future<void> SignOut() async {
  await FirebaseAuth.instance.signOut();
  userLogin = null;
  useMainLogin = null;
  cart = Cart();
}

Future<bool> checkIDExist(String collection, String idItem) async {
  try {
    if (collection.isEmpty || idItem.isEmpty) throw Exception(false);
    final doc =
        await FirebaseFirestore.instance
            .collection(collection)
            .doc(idItem)
            .get();
    return doc.exists;
  } catch (e) {
    return false;
  }
}

Future<bool> ChangePassword(
  String email,
  String password,
  String newPassword,
) async {
  try {
    AuthCredential credential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );

    await FirebaseAuth.instance.currentUser!.reauthenticateWithCredential(
      credential,
    );

    await FirebaseAuth.instance.currentUser!.updatePassword(newPassword);
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> resetPassword(String email) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> insertData(
  String collection,
  String idItem,
  Map<String, dynamic> data,
) async {
  try {
    if (collection.isEmpty || data.isEmpty || idItem.isEmpty) {
      throw Exception(false);
    }
    if (await checkIDExist(collection, idItem)) {
      throw Exception(false);
    }
    final url = FirebaseFirestore.instance.collection(collection);
    await url.doc(idItem).set(data);
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> insertDataAutoID(
  String collection,
  Map<String, dynamic> data,
) async {
  try {
    if (collection.isEmpty || data.isEmpty) {
      throw Exception(false);
    }
    await FirebaseFirestore.instance.collection(collection).add(data);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<Map<String, dynamic>?> getData(String collection, String idItem) async {
  try {
    if (collection.isEmpty || idItem.isEmpty) throw Exception(false);
    if (!await checkIDExist(collection, idItem)) throw Exception(false);
    final doc =
        await FirebaseFirestore.instance
            .collection(collection)
            .doc(idItem)
            .get();

    return doc.exists ? doc.data() : null;
  } catch (e) {
    return null;
  }
}

Future<bool> updateData(
  String collection,
  String idItem,
  Map<String, dynamic> data,
) async {
  try {
    if (collection.isEmpty || idItem.isEmpty || data.isEmpty) {
      throw Exception(false);
    }
    if (!await checkIDExist(collection, idItem)) throw Exception(false);
    final url = FirebaseFirestore.instance.collection(collection);
    await url.doc(idItem).update(data);
    return true;
  } catch (e) {
    return false;
  }
}

Future<List<Map<String, dynamic>>> getAllData(String collection) async {
  try {
    if (collection.isEmpty) throw Exception('Collection name is empty');

    final querySnapshot =
        await FirebaseFirestore.instance.collection(collection).get();

    return querySnapshot.docs.map((doc) => doc.data()).toList();
  } catch (e) {
    return [];
  }
}

Future<bool> deleteData(String collection, String idItem) async {
  try {
    if (collection.isEmpty || idItem.isEmpty) throw Exception(false);
    if (!await checkIDExist(collection, idItem)) throw Exception(false);
    final url = FirebaseFirestore.instance.collection(collection);
    await url.doc(idItem).delete();
    return true;
  } catch (e) {
    return false;
  }
}

// void showClause(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text(
//           "VNVC VÀ CHÍNH SÁCH VỀ DỮ LIỆU CÁ NHÂN",
//           style: TextStyle(color: Colors.black),
//         ),
//         content: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: const [
//               Text(
//                 "Ứng dụng VNVC (sau đây được gọi chung là “VNVC app”) được điều hành bởi Công ty Cổ phần Vacxin Việt Nam (sau đây gọi là “VNVC”/ “Chúng Tôi”), giúp kết nối VNVC với khách hàng (sau đây gọi là “Khách Hàng” hoặc “Người Dùng”) bằng cách ứng dụng các nền tảng công nghệ thông tin mới thông qua việc Khách Hàng sử dụng các dịch vụ do Chúng Tôi cung cấp (“Dịch Vụ”), với mong muốn mang lại tiện ích cho Người Dùng trong việc theo dõi, quản lý hồ sơ tiêm chủng, tương tác với chuyên gia, đặt mua các sản phẩm/dịch vụ của Chúng Tôi dễ dàng.",
//               ),
//               SizedBox(height: 8),
//               Text(
//                 "Chúng Tôi nhận thức được tầm quan trọng của các dữ liệu cá nhân mà Người Dùng trao cho Chúng tôi. Vì vậy, chính sách về dữ liệu cá nhân này (sau đây được gọi là “Chính Sách”) cung cấp thông tin tổng quan nhất về việc Chúng Tôi sẽ thực hiện một hoặc nhiều hoạt động tác động tới dữ liệu cá nhân như thu thập, ghi, phân tích, xác nhận, lưu trữ, chỉnh sửa, công khai, kết hợp, truy cập, truy xuất, thu hồi, mã hóa, giải mã, sao chép, chia sẻ, truyền đưa, cung cấp, chuyển giao, xóa, hủy dữ liệu cá nhân hoặc các hành động khác có liên quan đến dữ liệu cá nhân (“Xử Lý”) mà Người Dùng đã cung cấp cho Chúng Tôi, cũng như cách mà Chúng Tôi sẽ hỗ trợ Người Dùng trước khi đưa ra bất cứ quyết định nào liên quan đến việc Xử Lý dữ liệu cá nhân của Người Dùng.",
//               ),
//               SizedBox(height: 8),
//               Text(
//                 "I. Nguyên tắc chung:",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 "“Dữ Liệu Cá Nhân” của Người Dùng là bất kỳ thông tin, dữ liệu nào có thể được sử dụng để nhận dạng Người Dùng hoặc dựa vào đó mà Người Dùng được xác định, chẳng hạn như họ, chữ đệm và tên khai sinh, tên gọi khác; giới tính; nơi sinh, nơi đăng ký khai sinh, nơi thường trú, nơi tạm trú, nơi ở hiện tại, quê quán, địa chỉ liên hệ; quốc tịch; hình ảnh của cá nhân; số điện thoại, số chứng minh nhân dân, số định danh cá nhân...",
//               ),
//               SizedBox(height: 8),
//               Text(
//                 "II. Mục đích thu thập Dữ Liệu Cá Nhân của Người Dùng:",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 "Giới thiệu các hàng hóa và dịch vụ có thể phù hợp với các nhu cầu của Người Dùng. Cá nhân hóa luồng nội dung... và các mục đích khác như khảo sát, quảng bá, nâng cấp sản phẩm/dịch vụ...",
//               ),
//               SizedBox(height: 8),
//               Text(
//                 "III. Phạm vi thu thập thông tin:",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 "Chúng Tôi thu thập Dữ Liệu Cá Nhân của Người Dùng khi thực hiện giao dịch, đăng ký tài khoản, sử dụng Dịch Vụ, tham gia khảo sát... bao gồm cả thông tin tự động từ thiết bị và nguồn khác.",
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             child: const Text("Đóng"),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     },
//   );
// }

// void showPrivacy(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text(
//           "QUY ĐỊNH KHI ĐẶT GIỮ VẮC XIN",
//           style: TextStyle(color: Colors.black),
//         ),
//         content: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: const [
//               Text(
//                 "ĐỊNH NGHĨA\n",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 "● Người mua: là người đại diện thực hiện đăng ký thông tin và thanh toán cho bản thân hoặc người thân của mình.\n",
//               ),
//               Text(
//                 "- VNVC sẽ liên hệ với người mua để xác nhận chi tiết thông tin về ngày giờ và địa điểm tiêm chủng dựa theo mã đăng ký khách hàng được cung cấp ngay sau khi hoàn tất đặt mua hoặc/và thanh toán. Mỗi đơn đặt giữ vắc xin sẽ nhận được một mã đăng ký.\n",
//               ),
//               Text(
//                 "- Người mua phải là công dân Việt Nam hoặc người nước ngoài sinh sống hợp pháp tại Việt Nam trên 15 tuổi.\n\n",
//               ),

//               Text(
//                 "● Người tiêm: là người sẽ được tiêm loại vắc xin mà người mua đã đặt giữ nếu đạt đủ các tiêu chuẩn quy định về sức khỏe.\n",
//               ),
//               Text(
//                 "- VNVC chỉ thực hiện tiêm chủng cho người tiêm có thông tin cá nhân trùng khớp hoàn toàn với thông tin đã đặt giữ và có mối quan hệ theo quy định với người mua.\n",
//               ),
//               Text(
//                 "- Nếu người tiêm dưới 14 tuổi, các thông tin về số điện thoại, email, địa chỉ, nghề nghiệp và đơn vị công tác của người tiêm là thông tin đăng ký của người giám hộ hợp pháp.\n",
//               ),
//               Text(
//                 "- Tuỳ theo loại vắc xin đặt giữ, người tiêm cần trả lời một số câu hỏi sàng lọc trước khi hoàn tất đặt giữ vắc xin.\n\n",
//               ),

//               Text(
//                 "QUY ĐỊNH ĐĂNG KÝ\n",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 "● Một người mua được đăng ký với số lượng người tiêm không giới hạn.\n",
//               ),
//               Text(
//                 "● Người tiêm chỉ được đặt giữ tối đa 3 loại “Vắc xin đặt giữ theo yêu cầu”...\n",
//               ),
//               Text(
//                 "● Mũi tiêm tiếp theo chỉ được đặt giữ 28 ngày sau khi đã hoàn tất mũi tiêm trước...\n",
//               ),
//               Text(
//                 "● Một người tiêm có thể đặt giữ không giới hạn số lượng gói vắc xin.\n",
//               ),
//               Text(
//                 "● Tất cả đơn đặt giữ vắc xin đã thanh toán thành công cần có sự tư vấn và xác nhận...\n\n",
//               ),

//               Text(
//                 "QUY ĐỊNH VỀ GIÁ VẮC XIN\n",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 "*** Giá vắc xin bao gồm giá lẻ, giá gói và phí đặt giữ.\n\n",
//               ),

//               Text("GIÁ GÓI\n", style: TextStyle(fontWeight: FontWeight.bold)),
//               Text(
//                 "● Chúng tôi lựa chọn những vắc xin nhập khẩu từ nước ngoài...\n",
//               ),
//               Text(
//                 "● Chúng tôi cam kết cung cấp đầy đủ vắc xin theo gói của Quý khách hàng...\n",
//               ),
//               Text(
//                 "● Trường hợp có sự biến động lớn về giá nhập mua trên thị trường...\n\n",
//               ),

//               Text(
//                 "GIÁ VẮC XIN ĐẶT GIỮ\n",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 "Giá vắc xin đặt giữ theo yêu cầu = giá vắc xin + phí đặt giữ...\n",
//               ),
//               Text(
//                 "● Chi phí đảm bảo khách hàng được sử dụng vắc xin theo thời gian...\n",
//               ),
//               Text("● Chi phí lưu giữ, bảo quản vắc xin lên đến 12 tháng...\n"),
//               Text("● Chi phí chống trượt giá...\n"),
//               Text("● Chi phí vận chuyển, luân chuyển vắc xin...\n\n"),

//               Text(
//                 "QUY ĐỊNH CHUNG\n",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 "*** Bảng giá được áp dụng từ ngày 20/01/2021 cho đến khi có thông báo mới...\n",
//               ),
//               Text("*** Giá đã bao gồm chi phí khám, tư vấn với bác sĩ.\n"),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("Đóng"),
//           ),
//         ],
//       );
//     },
//   );
// }
