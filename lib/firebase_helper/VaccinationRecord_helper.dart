import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medihub_app/models/vaccinePackage_record.dart';
import 'package:medihub_app/models/vaccine_record.dart';

Future<List<VaccinationRecord>> getVaccinationRecords(String userId) async {
  final db = await FirebaseFirestore.instance;
  final snapshot =
      await db
          .collection('LICHSUTIEM_VACCINE')
          .where('userId', isEqualTo: userId)
          .get();

  return snapshot.docs
      .map((doc) => VaccinationRecord.fromMap(doc.data()))
      .toList();
}

Future<List<VaccinePackageRecord>> getVaccinePackageRecords(
  String userId,
) async {
  final db = await FirebaseFirestore.instance;
  final snapshot =
      await db
          .collection('LICHSUTIEM_GOI_VACCINE')
          .where('userId', isEqualTo: userId)
          .get();

  return snapshot.docs
      .map((doc) => VaccinePackageRecord.fromMap(doc.data()))
      .toList();
}
