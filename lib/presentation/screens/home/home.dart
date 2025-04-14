import 'package:flutter/material.dart';
import 'package:medihub_app/core/widgets/header_section.dart';
import 'package:medihub_app/core/widgets/news_section.dart'; // Import widget mới
import 'package:medihub_app/core/widgets/partnered_hospitals_section.dart';
import 'package:medihub_app/core/widgets/search_bar.dart';
import 'package:medihub_app/core/widgets/services_grid.dart';
import 'package:medihub_app/core/widgets/auto_image_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              const HomeSearchBar(),

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
