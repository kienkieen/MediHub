import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medihub_app/core/widgets/appbar.dart';
import 'package:medihub_app/core/widgets/search_bar.dart';
// import 'package:medihub_app/core/widgets/filter_vaccine_list.dart';
// import 'package:medihub_app/core/widgets/filterchip.dart';
import 'package:medihub_app/core/utils/constants.dart';
import 'package:medihub_app/models/vaccine.dart';
import 'package:medihub_app/models/user.dart';
import 'package:medihub_app/presentation/screens/services/vaccine_detail.dart';
import 'package:medihub_app/providers/cart_provider.dart';
import 'package:medihub_app/core/widgets/button2.dart';
import 'package:medihub_app/presentation/screens/services/cart.dart';

class VaccineForYouScreen extends StatefulWidget {
  const VaccineForYouScreen({super.key});

  @override
  State<VaccineForYouScreen> createState() => _VaccineForYouScreenState();
}

class _VaccineForYouScreenState extends State<VaccineForYouScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Vaccine> _vaccines = [];
  List<Vaccine> _filteredVaccines = [];
  FilterOptions _filterOptions = FilterOptions();
  User? _currentUser;
  String? _ageGroup;

  @override
  void initState() {
    super.initState();
    _loadVaccines();
    _initializeUser();
  }

  void _loadVaccines() {
    // Dữ liệu mẫu
    setState(() {
      _vaccines = vaccines;
      _filteredVaccines = _vaccines;
    });
  }

  void _initializeUser() {
    final user = User(
      userId: '12345',
      fullName: 'An Bùi',
      gender: 'Male',
      dateOfBirth: DateTime(2004, 3, 15),
      phoneNumber: '0987654321',
      email: 'An@gmail.com',
      address: 'Hà Nội, Việt Nam',
      idCardNumber: '012345678901',
      ethnicity: 'Kinh',
      nationality: 'Vietnam',
    );

    setState(() {
      _currentUser = user;
      _ageGroup = AgeService.getAgeGroup(
        AgeService.calculateAge(user.dateOfBirth),
      );
    });

    _applyFilters();
  }

  void _applyFilters() {
    setState(() {
      _filteredVaccines =
          _vaccines.where((vaccine) {
            if (_searchController.text.isNotEmpty &&
                !vaccine.name.toLowerCase().contains(
                  _searchController.text.toLowerCase(),
                )) {
              return false;
            }

            if (vaccine.ageRange != _ageGroup) {
              return false;
            }
            return true;
          }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppbarWidget(
        title: 'Vắc xin phù hợp với bạn',
        icon: Icons.shopping_bag_outlined,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CartScreen()),
          );
        },
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
            child: Search_Bar(
              controller: _searchController,
              hintText: 'Tìm theo tên vắc xin ...',
              onChanged: (value) => _applyFilters(),
              onClear: _applyFilters,
              onSubmitted: _applyFilters,
            ),
          ),

          Expanded(
            child:
                _filteredVaccines.isEmpty
                    ? _emptyContent()
                    : ListView.builder(
                      itemCount: _filteredVaccines.length,
                      itemBuilder:
                          (context, index) =>
                              _buildVaccineCard(_filteredVaccines[index]),
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildVaccineCard(Vaccine vaccine) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: InkWell(
        onTap:
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VaccineDetailPage(vaccine: vaccine),
              ),
            ),
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 0,
            left: 10,
            right: 10,
            bottom: 5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Vắc xin phù hợp với bạn *',
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
              SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      vaccine.imageUrl,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            if (vaccine.isPopular)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  'HOT',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                vaccine.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Phòng: ${vaccine.diseases.join(', ')}',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        Text(
                          'Tuổi: ${vaccine.ageRange}',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${vaccine.price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}đ',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                fontSize: 16,
                              ),
                            ),
                            const Icon(Icons.chevron_right, color: Colors.grey),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BuildButton3(
                    text: 'Thêm vào giỏ',
                    textSize: 14,
                    width: 150,
                    height: 42,
                    onPressed: () {
                      Provider.of<CartProvider>(
                        context,
                        listen: false,
                      ).addItem(vaccine);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${vaccine.name} đã được thêm vào giỏ hàng',
                          ),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                  BuildButton4(
                    text: 'Đặt lịch tiêm',
                    textSize: 14,
                    width: 150,
                    height: 42,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emptyContent() {
    return Center(
      // Dùng Center để căn giữa cả chiều ngang và dọc
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize:
              MainAxisSize.min, // Column chỉ chiếm không gian tối thiểu
          children: [
            Image.asset("assets/images/find_vaccie.png"),
            const SizedBox(height: 16),
            const Text(
              'Không tìm thấy vắc xin nào',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}
