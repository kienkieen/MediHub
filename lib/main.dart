import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:medihub_app/presentation/screens/services/vaccine_list.dart';
// import 'package:medihub_app/presentation/screens/services/vaccine_for_u.dart';
// import 'package:medihub_app/presentation/screens/services/vaccine_package.dart';
import 'package:medihub_app/presentation/screens/home/navigation.dart';
import 'package:medihub_app/providers/cart_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
