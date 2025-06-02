import 'package:cloud_firestore/cloud_firestore.dart';

class Bill {
  final String id;
  final String idUser;
  final String idBookig;
  final String paymentMethod;
  final double totalAmount;
  final DateTime dueDate;
  final bool isPaid;

  Bill({
    required this.id,
    required this.idUser,
    required this.idBookig,
    required this.paymentMethod,
    required this.totalAmount,
    required this.dueDate,
    required this.isPaid,
  });

  factory Bill.fromMap(Map<String, dynamic> map) {
    return Bill(
      id: map['id'] as String,
      idUser: map['idUser'] as String,
      idBookig: map['idBookig'] as String,
      paymentMethod: map['paymentMethod'] as String,
      totalAmount: (map['totalAmount'] as num).toDouble(),
      dueDate: (map['dueDate'] as Timestamp).toDate(),
      isPaid: map['isPaid'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idUser': idUser,
      'idBookig': idBookig,
      'paymentMethod': paymentMethod,
      'totalAmount': totalAmount,
      'dueDate': dueDate,
      'isPaid': isPaid,
    };
  }
}
