import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medihub_app/presentation/screens/services/vaccine_list.dart';
import 'package:medihub_app/presentation/screens/home/navigation.dart';
import 'package:medihub_app/presentation/screens/services/vaccine_for_u.dart';
import 'package:medihub_app/presentation/screens/services/vaccine_package.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediHub App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF0091FF),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0091FF)),
        useMaterial3: true,
        fontFamily: 'Sansita',
      ),
      home: const NavigationBottom(), // Change to NavigationScreen
    );
  }
}
