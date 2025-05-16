import 'package:medihub_app/models/vaccine.dart';

class VaccinationRecord {
  final Vaccine vaccine;
  final DateTime date;
  final String dose;
  final String location;
  final String vaccineId;

  VaccinationRecord({
    required this.vaccine,
    required this.date,
    required this.dose,
    required this.location,
    required this.vaccineId,
  });
}

List<VaccinationRecord> records = [
  VaccinationRecord(
    vaccine: vaccines[0],
    date: DateTime(2024, 5, 10),
    dose: 'Mũi 1',
    location: 'Bệnh viện Nhi Trung ương',
    vaccineId: 'v001',
  ),
  VaccinationRecord(
    vaccine: vaccines[1],
    date: DateTime(2024, 5, 10),
    dose: 'Mũi 2',
    location: 'Trung tâm Y tế Quận 1',
    vaccineId: 'v002',
  ),
  VaccinationRecord(
    vaccine: vaccines[2],
    date: DateTime(2023, 12, 20),
    dose: 'Mũi 3',
    location: 'Bệnh viện Bạch Mai',
    vaccineId: 'v003',
  ),
];
