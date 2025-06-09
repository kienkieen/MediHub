import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medihub_app/firebase_helper/firebase_helper.dart';
import 'package:medihub_app/models/vaccine_package.dart';

Future<List<VaccinePackage>> getAllVaccinePackage() async {
  List<Map<String, dynamic>> dataList = await getAllData('GOI_VACCINE');

  return dataList.map((data) => VaccinePackage.fromMap(data)).toList();
}

Future<void> updateAmountVaccinePackage(VaccinePackage v) async {
  await updateData('GOI_VACCINE', v.id, v.toMap());
}
