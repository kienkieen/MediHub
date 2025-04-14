import 'package:flutter/material.dart';
import 'package:medihub_app/core/widgets/header_section.dart';
import 'package:medihub_app/core/widgets/news_section.dart'; // Import widget mới
import 'package:medihub_app/core/widgets/partnered_hospitals_section.dart';
// import 'package:medihub_app/core/widgets/search_bar.dart';
import 'package:medihub_app/core/widgets/services_grid.dart';
import 'package:medihub_app/core/widgets/auto_image_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final headerHeight = screenHeight * 0.15; 
    return Scaffold(
      body: Stack(
        children: [
          // Phần hình ảnh background với góc bo tròn ở dưới
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: RoundedBottomClipper(),
              child: Container(
                height: headerHeight,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/background-gioi-thieu-vnvc-desk.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          
          // Phần nội dung chính
          SafeArea(
            child: Column(
              children: [
                // Header section
                const HeaderSection(),
                
                const SizedBox(height: 20), 
                // Search bar
                // const HomeSearchBar(),
                
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
        ],
      ),
      backgroundColor: Colors.white, // Màu trắng cho phần còn lại
    );
  }
}

// Custom clipper để tạo góc bo tròn ở phía dưới
class RoundedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final cornerRadius = 40.0; // Bán kính góc bo tròn
    
    // Bắt đầu từ góc trên bên trái
    path.lineTo(0, size.height - cornerRadius);
    
    // Vẽ góc bo tròn bên trái
    path.quadraticBezierTo(0, size.height, cornerRadius, size.height);
    
    // Vẽ cạnh dưới
    path.lineTo(size.width - cornerRadius, size.height);
    
    // Vẽ góc bo tròn bên phải
    path.quadraticBezierTo(size.width, size.height, size.width, size.height - cornerRadius);
    
    // Vẽ cạnh phải lên trên
    path.lineTo(size.width, 0);
    
    // Đóng đường dẫn
    path.close();
    
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}