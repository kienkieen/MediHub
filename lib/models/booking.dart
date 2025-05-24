import 'package:intl/intl.dart';
import 'package:medihub_app/models/vaccine.dart';

class Booking {
  String idUser;
  String idBooking;
  String bookingCenter;
  DateTime dateBooking;
  List<Vaccine> lstVaccine;
  int isConfirmed;

  Booking({
    required this.idUser,
    required this.idBooking,
    required this.bookingCenter,
    required this.dateBooking,
    required this.lstVaccine,
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
      'dateBooking': convertDate(dateBooking),
      'lstVaccine': lstVaccine.map((v) => v.toMap()).toList(),
      'isConfirmed': isConfirmed,
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      idBooking: map['idBooking'] as String? ?? '',
      idUser: map['idUser'] as String? ?? '',
      bookingCenter: map['bookingCenter'] as String? ?? '',
      dateBooking:
          map['dateBooking'] is DateTime
              ? map['dateBooking']
              : DateTime.parse(map['dateBooking']),
      lstVaccine:
          (map['lstVaccine'] as List<dynamic>?)
              ?.map((v) => Vaccine.fromMap(v as Map<String, dynamic>))
              .toList() ??
          [],

      isConfirmed: map['isConfirmed'] as int? ?? 0,
    );
  }
}
