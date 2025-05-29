import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:medihub_app/models/vaccine.dart';

class VaccinationRecord {
  final String? idRecord;
  final String userId;
  final Vaccine vaccine;
  final DateTime date;
  final String dose;
  final String location;
  final String vaccineId;

  VaccinationRecord({
    this.idRecord,
    required this.userId,
    required this.vaccine,
    required this.date,
    required this.dose,
    required this.location,
    required this.vaccineId,
  });

  String convertDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'vaccine': vaccine.toMap(),
      'date': date,
      'dose': dose,
      'location': location,
      'vaccineId': vaccineId,
    };
  }

  factory VaccinationRecord.fromMap(Map<String, dynamic> map) {
    return VaccinationRecord(
      idRecord: map['idRecord'],
      userId: map['userId'] ?? '',
      vaccine: Vaccine.fromMap(map['vaccine']),
      date: (map['date'] as Timestamp).toDate(),
      dose: map['dose'] ?? '',
      location: map['location'] ?? '',
      vaccineId: map['vaccineId'] ?? '',
    );
  }
}
