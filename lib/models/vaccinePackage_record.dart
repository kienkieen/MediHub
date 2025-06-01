import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:medihub_app/models/vaccine_package.dart';

class VaccinePackageRecord {
  final String? idRecord;
  final String userId;
  final VaccinePackage vaccinePackage;
  final DateTime date;
  final String dose;
  final String location;
  final String vaccinePackageId;

  VaccinePackageRecord({
    this.idRecord,
    required this.userId,
    required this.vaccinePackage,
    required this.date,
    required this.dose,
    required this.location,
    required this.vaccinePackageId,
  });

  String convertDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  Map<String, dynamic> toMap() {
    return {
      'idRecord': idRecord,
      'userId': userId,
      'vaccinePackage': vaccinePackage.toMap(),
      'date': date,
      'dose': dose,
      'location': location,
      'vaccinePackageId': vaccinePackageId,
    };
  }

  factory VaccinePackageRecord.fromMap(Map<String, dynamic> map) {
    return VaccinePackageRecord(
      idRecord: map['idRecord'],
      userId: map['userId'] ?? '',
      vaccinePackage: VaccinePackage.fromMap(map['vaccinePackage']),
      date: (map['date'] as Timestamp).toDate(),
      dose: map['dose'] ?? '',
      location: map['location'] ?? '',
      vaccinePackageId: map['vaccinePackage'] ?? '',
    );
  }
}
