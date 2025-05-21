import 'package:medihub_app/firebase_helper/firebase_helper.dart';
import 'package:medihub_app/models/vaccine.dart';

Future<List<Vaccine>> loadAllVaccines() async {
  List<Map<String, dynamic>> dataList = await getAllData('VACCINE');

  List<Vaccine> vaccines =
      dataList.map((data) => Vaccine.fromMap(data)).toList();

  return vaccines;
}
