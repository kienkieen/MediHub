import 'dart:async';
import 'package:flutter/material.dart';

class AutoImageSlider extends StatefulWidget {
  @override
  _AutoImageSliderState createState() => _AutoImageSliderState();
}

class _AutoImageSliderState extends State<AutoImageSlider> {
  final List<String> _images = [
    "assets/images/image_1.png",
    "assets/images/image_5.png",
    "assets/images/image_7.png",
    "assets/images/image_1.png",
    "assets/images/image_5.png",
    "assets/images/image_7.png",
  ];

  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.92);

    // Set up auto page switching every 5 seconds
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < _images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 120, // Chiều cao của slider
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (int index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: _images.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0), // Khoảng cách hai bên
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), // Bo góc đều hơn
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20), // Bo góc cho hình ảnh
                  child: AspectRatio(
                    aspectRatio: 16 / 9, // Tỷ lệ khung hình
                    child: Image.asset(
                      _images[index],
                      fit: BoxFit.cover, // Đảm bảo hình ảnh vừa khung
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12), // Khoảng cách lớn hơn giữa slider và dấu chấm
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_images.length, (index) {
            return AnimatedContainer(
              duration: Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: 4),
              width: _currentPage == index ? 16 : 8,
              height: 5,
              decoration: BoxDecoration(
                color: _currentPage == index ? Color(0xFF0099CC) : Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }
}