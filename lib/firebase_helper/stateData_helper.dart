import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medihub_app/presentation/screens/login/login.dart';

class StateDate_helper {
  Future<bool> getStateVaccines(BuildContext context) async {
    try {
      final doc =
          await FirebaseFirestore.instance
              .collection('STATE_DATA')
              .doc('vaccine')
              .get();
      if (doc.exists) {
        bool state = doc.data()?['state'] ?? false;
        // if (style) {
        //   showDialog(
        //     context: context,
        //     barrierDismissible: false,
        //     builder: (BuildContext context) {
        //       return AlertDialog(
        //         title: const Text('Thông báo'),
        //         content: const Text(
        //           'Phần mềm đang bảo trì, vui lòng quay lại sau.',
        //         ),
        //         actions: [
        //           TextButton(
        //             onPressed: () {
        //               exit(0);
        //             },
        //             child: const Text('Thoát'),
        //           ),
        //         ],
        //       );
        //     },
        //   );
        // }
        return state;
      } else {
        throw Exception('Document does not exist');
      }
    } catch (e) {
      print("Error getStateVaccines: $e");
      return true;
    }
  }

  Future<bool> getStateVaccinesPackage(BuildContext context) async {
    try {
      final doc =
          await FirebaseFirestore.instance
              .collection('STATE_DATA')
              .doc('vaccinePackage')
              .get();
      if (doc.exists) {
        bool state = doc.data()?['state'] ?? false;
        // if (style) {
        //   showDialog(
        //     context: context,
        //     barrierDismissible: false,
        //     builder: (BuildContext context) {
        //       return AlertDialog(
        //         title: const Text('Thông báo'),
        //         content: const Text(
        //           'Phần mềm đang bảo trì, vui lòng quay lại sau.',
        //         ),
        //         actions: [
        //           TextButton(
        //             onPressed: () {
        //               exit(0);
        //             },
        //             child: const Text('Thoát'),
        //           ),
        //         ],
        //       );
        //     },
        //   );
        // }
        return state;
      } else {
        throw Exception('Document does not exist');
      }
    } catch (e) {
      print("Error getStateVaccinesPackage: $e");
      return true;
    }
  }

  Future<bool> getStateUser(BuildContext context, String email) async {
    try {
      final doc =
          await FirebaseFirestore.instance
              .collection('STATE_DATA')
              .doc(email)
              .get();
      if (doc.exists) {
        bool state = doc.data()?['state'] ?? false;

        return state;
      } else {
        throw Exception('Document does not exist');
      }
    } catch (e) {
      return false;
    }
  }
}

void showListError(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Thông báo'),
        content: const Text('Phần mềm đang bảo trì, vui lòng quay lại sau.'),
        actions: [
          TextButton(
            onPressed: () {
              exit(0);
            },
            child: const Text('Thoát'),
          ),
        ],
      );
    },
  );
}

void showErrorUser(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Thông báo'),
        content: const Text(
          'Hãy chờ hoàn tất cập nhật dữ liệu người dùng và đăng nhập lại!',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(isNewLoginl: false),
                ),
              );
            },
            child: const Text('Đổi tài khoản'),
          ),
          TextButton(
            onPressed: () {
              exit(0);
            },
            child: const Text('Thoát'),
          ),
        ],
      );
    },
  );
}
