import 'package:flutter/material.dart';
import 'package:medihub_app/core/widgets/header_section.dart';
import 'package:medihub_app/core/widgets/news_section.dart';
import 'package:medihub_app/core/widgets/partnered_hospitals_section.dart';
import 'package:medihub_app/core/widgets/search_bar.dart';
import 'package:medihub_app/core/widgets/services_grid.dart';
import 'package:medihub_app/core/widgets/auto_image_slider.dart';
import 'package:medihub_app/main.dart';
import 'package:medihub_app/presentation/screens/services/vaccine_list.dart';
import 'package:medihub_app/presentation/screens/user_account/profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _VaccineListScreenState();
}

class _VaccineListScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  bool checkNull() {
    if (useMainLogin?.numberBHYT.isEmpty == true ||
        useMainLogin?.numberBHYT == null ||
        useMainLogin?.idCardNumber.isEmpty == true ||
        useMainLogin?.idCardNumber == null ||
        useMainLogin?.phoneNumber.isEmpty == true ||
        useMainLogin?.phoneNumber == null) {
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (userLogin != null && checkNull() == false) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Thông báo'),
              content: const Text(
                'Vui lòng cập nhật thông tin cá nhân trước khi sử dụng dịch vụ.',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ),
                    );
                  },
                  child: const Text('Cập nhật'),
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      // Phần nội dung chính
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF3397E8), // Màu xanh nhạt ở trên
              const Color(0xFFE8F9FF), // Màu trắng ở dưới
              Colors.white, // Màu trắng ở giữa
              Color(0xFFCCE5F9),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header section
              const HeaderSection(),

              // Search bar
              Search_Bar(
                controller: _searchController,
                hintText: 'Tìm vắc xin ...',
                onChanged: (value) => (),
                onClear: () {},
                onSubmitted: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => VaccineListScreen(
                            initialSearch: _searchController.text,
                          ),
                    ),
                  );
                },
              ),
              // Services cards and other content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const [
                      // Services
                      ServicesGrid(),

                      // Partnered hospitals section
                      PartneredHospitalsSection(),

                      SizedBox(height: 16), // Space between sections
                      AutoImageSlider(),

                      // Sử dụng NewsSection thay vì _NewsPageState
                      NewsSection(),
                      SizedBox(height: 70),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
