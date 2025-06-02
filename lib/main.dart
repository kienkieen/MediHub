import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medihub_app/firebase_helper/stateData_helper.dart';
import 'package:medihub_app/firebase_helper/vaccinePackage_helper.dart';
import 'package:medihub_app/firebase_helper/vaccine_helper.dart';
import 'package:medihub_app/models/cart.dart';
import 'package:medihub_app/models/userMain.dart';
import 'package:medihub_app/models/vaccine.dart';
import 'package:medihub_app/models/vaccine_package.dart';
import 'package:provider/provider.dart';
// import 'package:medihub_app/presentation/screens/services/vaccine_list.dart';
// import 'package:medihub_app/presentation/screens/services/vaccine_for_u.dart';
// import 'package:medihub_app/presentation/screens/services/vaccine_package.dart';
import 'package:medihub_app/presentation/screens/home/navigation.dart';
import 'package:medihub_app/providers/cart_provider.dart';

User? userLogin;
UserMain? useMainLogin;
List<Vaccine> allVaccines = [];
List<VaccinePackage> allVaccinePackages = [];
Cart cart = Cart();
StateDate_helper checkState = StateDate_helper();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
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

  // VaccinationRecord record = VaccinationRecord(
  //   idRecord: '',
  //   userId: 'pkTN29uKJhaRU77d8OzLuKvT8le2',
  //   vaccine: allVaccines[0],
  //   date: DateTime.now(),
  //   dose: 'Liều 1',
  //   location: 'VNVC',
  //   vaccineId: allVaccines[0].id,
  // );

  // VaccinePackageRecord record1 = VaccinePackageRecord(
  //   idRecord: '',
  //   userId: 'pkTN29uKJhaRU77d8OzLuKvT8le2',
  //   vaccinePackage: allVaccinePackages[0],
  //   date: DateTime.now(),
  //   dose: 'Liều 1',
  //   location: 'VNVC',
  //   vaccinePackageId: allVaccinePackages[0].id,
  // );

  // insertDataAutoID("LICHSUTIEM_VACCINE", record.toMap())
  //     .then((value) {
  //       print("Insert successful: $value");
  //     })
  //     .catchError((error) {
  //       print("Insert failed: $error");
  //     });

  // insertDataAutoID("LICHSUTIEM_GOI_VACCINE", record1.toMap())
  //     .then((value) {
  //       print("Insert successful: $value");
  //     })
  //     .catchError((error) {
  //       print("Insert failed: $error");
  //     });

  // final List<VaccinePackage> _vaccinePackages = [
  //   VaccinePackage(
  //     id: '6_thang',
  //     name: 'Gói vắc xin cho trẻ 6 tháng',
  //     ageGroup: 'Từ 0 đến 6 tháng',
  //     description:
  //         'Việc tiêm vắc xin cho trẻ từ 0 đến 6 tháng tuổi là cực kỳ quan trọng vì hệ miễn dịch'
  //         'của trẻ ở độ tuổi này còn yếu và chưa phát triển đầy đủ. Tiêm vắc xin giúp bảo vệ trẻ'
  //         'khỏi các bệnh nguy hiểm, đặc biệt là những bệnh truyền nhiễm có thể gây tử vong hoặc'
  //         'để lại di chứng nghiêm trọng, như bạch hầu, ho gà, uốn ván, tiêu chảy, bệnh do phế cầu, bệnh cúm.',
  //     vaccineIds: ['vaccine1', 'vaccine2'],
  //     dosesByVaccine: {
  //       'vaccine1': 2, // Vaccine 1 cần 2 liều
  //       'vaccine2': 3, // Vaccine 2 cần 3 liều
  //     },
  //     totalPrice: 9161300,
  //     discount: 440000,
  //     imageUrl: 'assets/icons/vaccine_package/package1.png',
  //   ),
  //   VaccinePackage(
  //     id: '12_thang',
  //     name: 'Gói vắc xin cho trẻ 12 tháng',
  //     ageGroup: 'Từ 0 đến 12 tháng',
  //     description:
  //         'Việc tiêm vắc xin cho trẻ từ 0 đến 12 tháng tuổi là rất cần thiết vì hệ miễn dịch của'
  //         'trẻ trong giai đoạn này còn yếu, dễ bị tấn công bởi các bệnh truyền nhiễm nguy hiểm. '
  //         'Các loại vắc xin quan trọng như 6 trong 1, vắc xin cúm giúp phòng ngừa các bệnh có thể'
  //         'gây tử vong hoặc để lại di chứng nghiêm trọng, bảo vệ trẻ khỏi các biến chứng nặng nề do bệnh gây ra.',
  //     vaccineIds: ['vaccine3'],
  //     dosesByVaccine: {
  //       'vaccine3': 1, // Vaccine 3 cần 1 liều
  //     },
  //     totalPrice: 8550000,
  //     discount: 640000,
  //     imageUrl: 'assets/icons/vaccine_package/package2.png',
  //   ),
  //   VaccinePackage(
  //     id: '24_thang',
  //     name: 'Gói vắc xin cho trẻ 24 tháng',
  //     ageGroup: 'Từ 0 đến 24 tháng',
  //     description:
  //         'Việc tiêm vắc xin cho trẻ từ 0 đến 12 tháng tuổi là rất cần thiết vì hệ miễn dịch của'
  //         'trẻ trong giai đoạn này còn yếu, dễ bị tấn công bởi các bệnh truyền nhiễm nguy hiểm. '
  //         'Các loại vắc xin quan trọng như 6 trong 1, vắc xin cúm giúp phòng ngừa các bệnh có thể'
  //         'gây tử vong hoặc để lại di chứng nghiêm trọng, bảo vệ trẻ khỏi các biến chứng nặng nề do bệnh gây ra.',
  //     vaccineIds: ['vaccine1', 'vaccine2', 'vaccine3'],
  //     dosesByVaccine: {'vaccine1': 1, 'vaccine3': 3, 'vaccine2': 2},
  //     totalPrice: 12550000,
  //     discount: 1000000,
  //     imageUrl: 'assets/icons/vaccine_package/package3.png',
  //   ),
  //   VaccinePackage(
  //     id: 'tien_hoc_duong',
  //     name: 'Gói vắc xin cho trẻ tiền học đường (từ 3 - 9 tuổi)',
  //     ageGroup: 'Từ 3 đến 9 tuổi',
  //     description:
  //         'Việc tiêm vắc xin cho trẻ từ 0 đến 12 tháng tuổi là rất cần thiết vì hệ miễn dịch của'
  //         'trẻ trong giai đoạn này còn yếu, dễ bị tấn công bởi các bệnh truyền nhiễm nguy hiểm. '
  //         'Các loại vắc xin quan trọng như 6 trong 1, vắc xin cúm giúp phòng ngừa các bệnh có thể'
  //         'gây tử vong hoặc để lại di chứng nghiêm trọng, bảo vệ trẻ khỏi các biến chứng nặng nề do bệnh gây ra.',
  //     vaccineIds: [],
  //     dosesByVaccine: {},
  //     totalPrice: 12550000,
  //     discount: 1000000,
  //     imageUrl: 'assets/icons/vaccine_package/package4.png',
  //   ),
  // ];

  // for (var package in _vaccinePackages) {
  //   final success = await insertData(
  //     'GOI_VACCINE',
  //     package.id,
  //     package.toMap(),
  //   );
  //   if (success) {
  //     print('Inserted package: ${package.name}');
  //   } else {
  //     print('Failed to insert package: ${package.name}');
  //   }
  // }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  // Future<bool> checktStateList(BuildContext context) async {
  //   bool v = await checkState.getStateVaccines(context);
  //   bool vp = await checkState.getStateVaccinesPackage(context);
  //   return !(v && vp);
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return ChangeNotifierProvider(
  //     create: (context) => CartProvider(),
  //     child: MaterialApp(
  //       title: 'VNVC',
  //       debugShowCheckedModeBanner: false,
  //       theme: ThemeData(
  //         primaryColor: const Color(0xFF0091FF),
  //         colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0091FF)),
  //         useMaterial3: true,
  //         fontFamily: 'Calistoga',
  //       ),

  //       home: const NavigationBottom(), // Change to NavigationScreen
  //     ),
  //   );
  // }
}

class _MyAppState extends State<MyApp> {
  late Future<bool> _checkFuture;

  @override
  void initState() {
    super.initState();
    _checkFuture = checktStateList(context);
  }

  Future<bool> checktStateList(BuildContext context) async {
    bool v = await checkState.getStateVaccines(context);
    bool vp = await checkState.getStateVaccinesPackage(context);
    return (!v && !vp); // true = OK to run
  }

  void setUpList() async {
    allVaccines = await loadAllVaccines();
    allVaccinePackages = await getAllVaccinePackage();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FutureBuilder<bool>(
        future: _checkFuture, // Future của bạn
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return const Scaffold(
              body: Center(child: Text('Lỗi khi kiểm tra trạng thái dữ liệu')),
            );
          } else if (snapshot.hasData && snapshot.data == false) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          size: 80,
                          color: Colors.orange,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Hệ thống đang bảo trì',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Vui lòng quay lại sau khi bảo trì hoàn tất.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton.icon(
                          onPressed: () {
                            exit(0); // Thoát app
                          },
                          icon: const Icon(Icons.exit_to_app),
                          label: const Text('Thoát'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 12,
                            ),
                            backgroundColor: Colors.redAccent,
                            foregroundColor: Colors.white,
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            setUpList();
            return ChangeNotifierProvider(
              create: (context) => CartProvider(),
              child: MaterialApp(
                title: 'VNVC',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primaryColor: const Color(0xFF0091FF),
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: const Color(0xFF0091FF),
                  ),
                  useMaterial3: true,
                  fontFamily: 'Calistoga',
                ),
                home: const NavigationBottom(),
              ),
            );
          }
        },
      ),
    );
  }
}
