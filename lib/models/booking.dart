import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:medihub_app/models/vaccine.dart';
import 'package:medihub_app/models/vaccine_package.dart';

class Booking {
  String idUser;
  String idBooking;
  String bookingCenter;
  DateTime dateBooking;
  List<String> lstVaccine;
  List<String> lstVaccinePackage;
  int isConfirmed;
  double totalPrice;

  Booking({
    required this.idUser,
    required this.idBooking,
    required this.bookingCenter,
    required this.dateBooking,
    required this.lstVaccine,
    required this.lstVaccinePackage,
    required this.totalPrice,
    this.isConfirmed = 0,
  });

  String convertDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  Map<String, dynamic> toMap() {
    return {
      'idBooking': idBooking,
      'idUser': idUser,
      'bookingCenter': bookingCenter,
      'dateBooking': dateBooking,
      'lstVaccine': lstVaccine,
      'lstVaccinePackage': lstVaccinePackage,
      'totalPrice': totalPrice,
      'isConfirmed': isConfirmed,
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      idBooking: map['idBooking'] as String? ?? '',
      idUser: map['idUser'] as String? ?? '',
      bookingCenter: map['bookingCenter'] as String? ?? '',
      dateBooking: (map['dateBooking'] as Timestamp).toDate(),
      lstVaccine:
          (map['lstVaccine'] as List<dynamic>?)
              ?.map((v) => v as String)
              .toList() ??
          [],
      lstVaccinePackage:
          (map['lstVaccinePackage'] as List<dynamic>?)
              ?.map((v) => v as String)
              .toList() ??
          [],
      totalPrice: (map['totalPrice'] as num?)?.toDouble() ?? 0.0,

      isConfirmed: map['isConfirmed'] as int? ?? 0,
    );
  }
}
