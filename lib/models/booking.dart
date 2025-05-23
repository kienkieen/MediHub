import 'package:intl/intl.dart';
import 'package:medihub_app/models/vaccine.dart';

class Booking {
  String idUser;
  String bookingCenter;
  DateTime dateBooking;
  List<Vaccine> lstVaccine;

  Booking({
    required this.idUser,
    required this.bookingCenter,
    required this.dateBooking,
    required this.lstVaccine,
  });

  String convertDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  Map<String, dynamic> toMap() {
    return {
      'idUser': idUser,
      'bookingCenter': bookingCenter,
      'dateBooking': convertDate(dateBooking),
      'lstVaccine': lstVaccine.map((v) => v.toMap()).toList(),
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      idUser: map['idUser'],
      bookingCenter: map['bookingCenter'],
      dateBooking: DateTime.parse(map['dateBooking']),
      lstVaccine: List<Vaccine>.from(
        (map['lstVaccine'] as List).map((v) => Vaccine.fromMap(v)),
      ),
    );
  }
}
