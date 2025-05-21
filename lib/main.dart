import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medihub_app/firebase_helper/firebase_helper.dart';
import 'package:medihub_app/firebase_helper/vaccine_helper.dart';
import 'package:medihub_app/models/userMain.dart';
import 'package:medihub_app/models/vaccine.dart';
import 'package:provider/provider.dart';
// import 'package:medihub_app/presentation/screens/services/vaccine_list.dart';
// import 'package:medihub_app/presentation/screens/services/vaccine_for_u.dart';
// import 'package:medihub_app/presentation/screens/services/vaccine_package.dart';
import 'package:medihub_app/presentation/screens/home/navigation.dart';
import 'package:medihub_app/providers/cart_provider.dart';

User? userLogin;
UserMain? useMainLogin;
List<Vaccine> allVaccines = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // final List<Vaccine> allVaccines = [
  //   Vaccine(
  //     id: 'vaccine1',
  //     name: 'PREVENAR 13.0.5ML INJ',
  //     description: 'Phòng bệnh do Phế cầu',
  //     diseases: ['Phế cầu'],
  //     ageRange: '6 tháng - 5 tuổi',
  //     price: 333050,
  //     importedDate: DateTime(2023, 1, 1),
  //     manufacturer: 'Bi',
  //     imageUrl: 'assets/icons/vaccine/vaccine1.png',
  //     vaccinationSchedules: [],
  //     administrationRoute: 'Tiêm bắp',
  //     contraindications: [],
  //     storageCondition: '2-8°C',
  //   ),
  //   Vaccine(
  //     id: 'vaccine2',
  //     name: 'Vắc xin tổng hợp',
  //     description: 'Phòng đa bệnh',
  //     diseases: ['Đa bệnh'],
  //     ageRange: '6 tháng - 5 tuổi',
  //     price: 383080,
  //     importedDate: DateTime(2023, 1, 1),
  //     manufacturer: 'Đa quốc gia',
  //     imageUrl: 'assets/icons/vaccine/vaccine2.png',
  //     vaccinationSchedules: [],
  //     administrationRoute: 'Tiêm bắp',
  //     contraindications: [],
  //     storageCondition: '2-8°C',
  //   ),
  //   Vaccine(
  //     id: 'vaccine3',
  //     name: 'VAXIGRIP TETRA',
  //     description: 'Phòng Cúm',
  //     diseases: ['Cúm'],
  //     ageRange: '6 tháng - 5 tuổi',
  //     price: 355000,
  //     importedDate: DateTime(2023, 1, 1),
  //     manufacturer: 'Pháp',
  //     imageUrl: 'assets/icons/vaccine/vaccine3.png',
  //     vaccinationSchedules: [],
  //     administrationRoute: 'Tiêm bắp',
  //     contraindications: [],
  //     storageCondition: '2-8°C',
  //   ),
  // ];
  // for (var vaccine in allVaccines) {
  //   final success = await insertData('VACCINE', vaccine.id, vaccine.toMap());
  // }

  allVaccines = await loadAllVaccines();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        title: 'VNVC',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFF0091FF),
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0091FF)),
          useMaterial3: true,
          fontFamily: 'Calistoga',
        ),

        home: const NavigationBottom(), // Change to NavigationScreen
      ),
    );
  }
}
