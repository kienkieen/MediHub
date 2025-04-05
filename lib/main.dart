import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medpro Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF0091FF),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0091FF)),
        useMaterial3: true,
      ),
      //home: const LoginScreen(),
    );
  }
}