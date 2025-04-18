import 'package:flutter/material.dart';
import 'package:medihub_app/presentation/screens/home/navigation.dart';
// import 'package:medihub_app/presentation/screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VNVC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF0091FF),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0091FF)),
        useMaterial3: true,
        // fontFamily: 'calistoga',
      ),
      home: const NavigationBottom(), // Change to NavigationScreen
    );
  }
}