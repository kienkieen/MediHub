import 'package:flutter/material.dart';
import 'package:medihub_app/core/widgets/auto_image_slider.dart';
import 'package:medihub_app/core/widgets/hospital_card.dart';
import 'package:flutter_svg/flutter_svg.dart';


class MedihubHomeScreen extends StatelessWidget {
  const MedihubHomeScreen({Key? key}) : super(key: key);
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
              Colors.white, // Màu trắng ở giữa
              Color(0xFFCCE5F9),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header section
              _buildHeader(),
              
              // Search bar
              _buildSearchBar(),
              
              // Services cards
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Main services
                      _buildServicesGrid(),
                      
                      // Partnered hospitals section
                      _buildPartneredHospitalsSection(),
                      
                      const SizedBox(height: 16), // Space between sections
                      AutoImageSlider(),
                      
                      _buildMedicalFacilitiesSection(),
                      const SizedBox(height: 70), // Space for bottom navigation
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      "MH",
                      style: TextStyle(
                        color: Color(0xFF0099CC),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    "MediHub\nXin chào,",
                    style: TextStyle(
                      color: Color(0xFF004466),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                    // overflow: TextOverflow.ellipsis, // Đảm bảo chữ không tràn
                    softWrap: true, // Cho phép xuống dòng
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color(0xFF0099CC)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Tất cả/VI",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xFF0099CC),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: "Tìm CSYT/bác sĩ/chuyên khoa/dịch vụ",
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
            prefixIcon: Icon(Icons.search, color: Colors.grey),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),
    );
  }

  Widget _buildServicesGrid() {
    final List<Map<String, dynamic>> topServices = [
      {
        'image': 'assets/icons/icon_4.png',
        'label': 'Đặt khám tại cơ sở',
      },
      {
        'image': 'assets/icons/icon_1.png',
        'label': 'Gọi video với bác sĩ',
      },
      {
        'image': 'assets/icons/icon_6.png',
        'label': 'Đặt khám ngoài giờ',
      },
      {
        'image': 'assets/icons/icon_3.png',
        'label': 'Đặt lịch tiêm chủng',
      },
    ];

    final List<Map<String, dynamic>> bottomServices = [
      {
        'image': 'assets/icons/icon_7.png',
        'label': 'Đặt khám Bác sĩ',
      },
      {
        'image': 'assets/icons/icon_8.png',
        'label': 'Gói sức khỏe toàn diện',
      },
      {
        'image': 'assets/icons/icon_5.png',
        'label': 'Đặt lịch xét nghiệm',
      },
      {
        'image': 'assets/icons/icon_2.png',
        'label': 'Kết quả khám bệnh',
      },
    ];
    
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            _buildServiceRow(topServices),
            const SizedBox(height: 16),
            _buildServiceRow(bottomServices),
            const SizedBox(height: 8),         
          ],
        ),
      ),
    );
  }

  Widget _buildServiceRow(List<Map<String, dynamic>> services) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: services.map((service) {
        return Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    service['image'],
                    width: 32,
                    height: 32,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: 80, // Giới hạn chiều rộng để chữ xuống dòng
                child: Text(
                  service['label'],
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis, // Ẩn nếu quá dài
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPartneredHospitalsSection() {
    final ScrollController _scrollController = ScrollController();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "ĐƯỢC TIN TƯỞNG HỢP TÁC VÀ ĐỒNG HÀNH",
            style: TextStyle(
              color: Color(0xFF004466),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 120, // Tăng chiều cao để chứa cả mũi tên
            child: Stack(
              children: [
                // ListView hiển thị các bệnh viện
                ListView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  children: [
                    HospitalCard(
                      name: "Bệnh viện Đại học Y Dược TP.HCM",
                      imagePath: "assets/images/image_10.png",
                    ),
                    HospitalCard(
                      name: "Bệnh viện Nhi Đồng 1",
                      imagePath: "assets/images/image_11.png",
                    ),
                    HospitalCard(
                      name: "Bệnh viện Chấn Thương Chỉnh Hình",
                      imagePath: "assets/images/image_14.png",
                    ),
                    HospitalCard(
                      name: "Bệnh viện Nhi Đồng Thành Phố",
                      imagePath: "assets/images/image_12.png",
                    ),
                    HospitalCard(
                      name: "Bệnh viện Da Liễu TP.HCM",
                      imagePath: "assets/images/image_13.png",
                    ),
                    HospitalCard(
                      name: "Bệnh viện Mắt TP.HCM",
                      imagePath: "assets/images/image_15.png",
                    ),
                    HospitalCard(
                      name: "Bệnh viện Quận Bình Thạch",
                      imagePath: "assets/images/image_16.png",
                    ),
                  ],
                ),
                // Mũi tên bên trái
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: () {
                      _scrollController.animateTo(
                        _scrollController.offset - 120, // Cuộn sang trái
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Container(
                      width: 40,
                      color: Colors.transparent, // Để dễ nhấn
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xFF0099CC),
                      ),
                    ),
                  ),
                ),
                // Mũi tên bên phải
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: () {
                      _scrollController.animateTo(
                        _scrollController.offset + 120, // Cuộn sang phải
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Container(
                      width: 40,
                      color: Colors.transparent, // Để dễ nhấn
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFF0099CC),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicalFacilitiesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min, // Đảm bảo chỉ dùng không gian cần thiết
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'CƠ SỞ Y TẾ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF004466),
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  minimumSize: Size.zero, // Giảm kích thước tối thiểu
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min, // Đảm bảo button chỉ rộng theo nội dung
                  children: const [
                    Text(
                      'Xem tất cả',
                      style: TextStyle(color: Color(0xFF0099CC), fontSize: 12),
                    ),
                    SizedBox(width: 2),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: Color(0xFF0099CC),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
          child: Text(
            'đặt khám nhiều nhất',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ),
        SizedBox(
          height: 230, // Giảm chiều cao để phù hợp với các thẻ đã điều chỉnh
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            physics: const BouncingScrollPhysics(), // Thêm physics để có hiệu ứng cuộn mượt
            clipBehavior: Clip.none, // Tránh cắt nội dung khi cuộn
            children: [
              HospitalCardDetail(
                name: "Bệnh viện Đại học Y Dược TP.HCM",
                address: "Nguyễn Chí Thanh, Q.5, TP.HCM",
                rating: 4.7,
                ratingCount: 93,
                imagePath: "assets/images/image_10.png",
              ),
              HospitalCardDetail(
                name: "Bệnh viện Nhi Đồng 1",
                address: "Quận 10, TP.HCM",
                rating: 4.6,
                ratingCount: 85,
                imagePath: "assets/images/image_11.png",
              ),
              HospitalCardDetail(
                name: "Bệnh viện Nhi Đồng Thành Phố",
                address: "Quận 5, TP.HCM",
                rating: 4.8,
                ratingCount: 120,
                imagePath: "assets/images/image_12.png",
              ),
              HospitalCardDetail(
                name: "Bệnh viện Da Liễu TP.HCM",
                address: "Quận 3, TP.HCM",
                rating: 4.5,
                ratingCount: 70,
                imagePath: "assets/images/image_13.png",
              ),
              HospitalCardDetail(
                name: "Bệnh viện Chấn Thương Chỉnh Hình",
                address: "Quận 5, TP.HCM",
                rating: 4.4,
                ratingCount: 60,
                imagePath: "assets/images/image_14.png",
              ),
              HospitalCardDetail(
                name: "Bệnh viện Mắt TP.HCM",
                address: "Quận 3, TP.HCM",
                rating: 4.7,
                ratingCount: 95,
                imagePath: "assets/images/image_15.png",
              ),
              HospitalCardDetail(
                name: "Bệnh viện Quận Bình Thạnh",
                address: "Quận Bình Thạnh, TP.HCM",
                rating: 4.3,
                ratingCount: 50,
                imagePath: "assets/images/image_16.png",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem("assets/icons/home.svg", "Trang chủ", isSelected: true),
            _buildNavItem("assets/icons/folder.svg", "Hồ sơ"),
            _buildNavItem("assets/icons/medical_note.svg", "Phiếu khám"),
            _buildNavItem("assets/icons/notification.svg", "Thông báo"),
            _buildNavItem("assets/icons/user.svg", "Tài khoản"),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String iconPath, String label, {bool isSelected = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          iconPath,
          height: 24,
          width: 24,
          colorFilter: ColorFilter.mode(
            isSelected ? Color(0xFF0099CC) : const Color.fromARGB(255, 41, 41, 41),
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? Color(0xFF0099CC) : const Color.fromARGB(255, 41, 41, 41),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  } 
}