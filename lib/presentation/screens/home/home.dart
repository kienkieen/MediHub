// File: home_screen.dart
import 'package:flutter/material.dart';
import 'package:medihub_app/core/widgets/header_section.dart';
import 'package:medihub_app/core/widgets/medical_facilities_section.dart';
import 'package:medihub_app/core/widgets/partnered_hospitals_section.dart';
import 'package:medihub_app/core/widgets/search_bar.dart';
import 'package:medihub_app/core/widgets/services_grid.dart';

import 'package:medihub_app/core/widgets/auto_image_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFCCE5F9), // Màu xanh nhạt ở trên
              Colors.white,      // Màu trắng ở dưới
              Colors.white,      // Màu trắng ở giữa
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
                      // AutoImageSlider(),
                      AutoImageSlider(),
                      
                      // Medical facilities section
                      MedicalFacilitiesSection(),
                      SizedBox(height: 70), 
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}