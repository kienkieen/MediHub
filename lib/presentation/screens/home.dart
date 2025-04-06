import 'package:flutter/material.dart';
import 'package:medihub_app/core/widgets/hospital_card.dart';


class MedihubHomeScreen extends StatelessWidget {
  const MedihubHomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                    
                    // Vaccination banner
                    _buildVaccinationBanner(),
                    
                    const SizedBox(height: 70), // Space for bottom navigation
                  ],
                ),
              ),
            ),
          ],
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
                    "MediHub xin chào,",
                    style: TextStyle(
                      color: Color(0xFF004466),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis, // Đảm bảo chữ không tràn
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF0099CC)),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Tất cả/VI",
                  style: TextStyle(
                    color: Color(0xFF0099CC),
                    fontWeight: FontWeight.w500,
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
                  style: TextStyle(fontSize: 12),
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
                    HospitalCard(name: "Bệnh viện Đại học Y Dược TP.HCM"),
                    HospitalCard(name: "Bệnh viện Nhi Đồng 1"),
                    HospitalCard(name: "Bệnh viện Chợ Rẫy"),
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

  Widget _buildVaccinationBanner() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xFF0066CC), Color(0xFF0099FF)],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "MUỐN VẮN GỌI TIÊM CHỦNG",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "AN TÂM\nKHÔNG ĐỢI CHỜ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        "ĐẶT LỊCH NGAY",
                        style: TextStyle(
                          color: Color(0xFF0099CC),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Image.network(
                "/api/placeholder/250/160",
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
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
            _buildNavItem(Icons.home, "Trang chủ", isSelected: true),
            _buildNavItem(Icons.folder_open, "Hồ sơ"),
            _buildNavItem(Icons.assignment, "Phiếu khám"),
            _buildNavItem(Icons.notifications_none, "Thông báo"),
            _buildNavItem(Icons.person_outline, "Tài khoản"),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, {bool isSelected = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isSelected ? Color(0xFF0099CC) : Colors.grey,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? Color(0xFF0099CC) : Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}