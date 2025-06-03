import 'package:medihub_app/firebase_helper/firebase_helper.dart';
import 'package:medihub_app/models/diseases.dart';
import 'package:medihub_app/models/supplier.dart';
import 'package:medihub_app/models/vaccine.dart';

Future<List<Vaccine>> loadAllVaccines() async {
  List<Map<String, dynamic>> dataList = await getAllData('VACCINE');

  List<Vaccine> vaccines =
      dataList.map((data) => Vaccine.fromMap(data)).toList();

  return vaccines;
}

Future<List<Diseases>> loadDisease() async {
  List<Map<String, dynamic>> dataList = await getAllData('DANHMUC_BENH');

  List<Diseases> diseases =
      dataList.map((data) => Diseases.fromMap(data)).toList();

  return diseases;
}

Future<List<Supplier>> loadSupplier() async {
  List<Map<String, dynamic>> dataList = await getAllData('NHACUNGCAP');

  List<Supplier> suppliers =
      dataList.map((data) => Supplier.fromMap(data)).toList();

  return suppliers;
}
