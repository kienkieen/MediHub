import 'package:flutter/material.dart';
import 'package:medihub_app/core/widgets/appbar.dart';
import 'package:medihub_app/core/widgets/search_bar.dart';
// import 'package:medihub_app/core/widgets/filter_vaccine_list.dart';
// import 'package:medihub_app/core/widgets/filterchip.dart';
import 'package:medihub_app/core/utils/constants.dart';
import 'package:medihub_app/models/vaccine.dart';
import 'package:medihub_app/models/user.dart';
import 'package:medihub_app/presentation/screens/services/vaccine_detail.dart';
import 'package:medihub_app/presentation/screens/home/navigation.dart';

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
      _vaccines = [
        Vaccine(
          id: 'v001',
          name: 'Vắc xin 6 trong 1 Hexaxim',
          description:
              'Vắc xin Prevenar 13 (Bỉ) phòng các bệnh phế cầu khuẩn xâm lấn gây nguy hiểm cho trẻ em và người lớn như viêm phổi, viêm màng não, viêm tai giữa cấp tính, nhiễm khuẩn huyết (nhiễm trùng máu)… do phế cầu khuẩn Streptococcus Pneumoniae gây ra.',
          diseases: [
            'Bạch hầu',
            'Uốn ván',
            'Ho gà',
            'Bại liệt',
            'Hib',
            'Viêm gan B',
          ],
          ageRange: '0-1 tuổi',
          price: 1850000,
          importedDate: DateTime(2023, 10, 15),
          manufacturer: 'Sanofi (Pháp)',
          isPopular: true,
          imageUrl: 'assets/images/vaccine/vc1.jpg',
          vaccinationSchedules: [
            VaccinationSchedule(
              ageGroup: 'Trẻ 6 tuần tuổi đến dưới 7 tháng',
              doses: [
                'Mũi 1: Lần tiêm đầu tiên',
                'Mũi 2: 1 tháng sau mũi 1',
                'Mũi 3: 1 tháng sau mũi 2',
                'Mũi 4: 6 tháng sau mũi 3',
              ],
            ),
            VaccinationSchedule(
              ageGroup: 'Trẻ 7 tháng tuổi đến dưới 1 tuổi',
              doses: [
                'Mũi 1: Lần tiêm đầu tiên',
                'Mũi 2: 1 tháng sau mũi 1',
                'Mũi 3: 6 tháng sau mũi 2',
              ],
            ),
            VaccinationSchedule(
              ageGroup: 'Trẻ 1 tuổi đến dưới 6 tuổi',
              doses: ['Mũi 1: Lần tiêm đầu tiên', 'Mũi 2: 2 tháng sau mũi 1'],
            ),
          ],
          administrationRoute: 'Tiêm bắp',
          contraindications: [
            'Phụ nữ có thai',
            'Người có tiền sử dị ứng nặng',
            'Bệnh nhân mắc bệnh thể ẩn và trong giai đoạn dưỡng bệnh',
            'Người có bệnh lý nền nặng',
            'Người đang điều trị bằng thuốc ức chế miễn dịch',
            'Người đang điều trị bằng thuốc kháng virus',
            'Người có triệu chứng co giật trong vòng 1 năm trước khi tiêm chủng',
          ],
          storageCondition: '2-8°C, không đông băng',
          precautions: [
            'Hoãn tiêm nếu trẻ sốt ≥ 38°C',
            'Theo dõi 30 phút sau tiêm',
          ],
          sideEffects: ['Sưng đau tại chỗ tiêm', 'Quấy khóc', 'Sốt nhẹ < 39°C'],
        ),
        Vaccine(
          id: 'v002',
          name: 'Vắc xin Gardasil (HPV)',
          description:
              'Vắc xin Prevenar 13 (Bỉ) phòng các bệnh phế cầu khuẩn xâm lấn gây nguy hiểm cho trẻ em và người lớn như viêm phổi, viêm màng não, viêm tai giữa cấp tính, nhiễm khuẩn huyết (nhiễm trùng máu)… do phế cầu khuẩn Streptococcus Pneumoniae gây ra.',
          diseases: ['HPV type 6,11,16,18', 'Ung thư cổ tử cung', 'Sùi mào gà'],
          ageRange: '1-5 tuổi',
          price: 3200000,
          importedDate: DateTime(2023, 9, 20),
          manufacturer: 'Merck (Mỹ)',
          isPopular: true,
          imageUrl: 'assets/images/vaccine/vc2.jpg',
          vaccinationSchedules: [
            VaccinationSchedule(
              ageGroup: 'Trẻ 6 tuần tuổi đến dưới 7 tháng',
              doses: [
                'Mũi 1: Lần tiêm đầu tiên',
                'Mũi 2: 1 tháng sau mũi 1',
                'Mũi 3: 1 tháng sau mũi 2',
                'Mũi 4: 6 tháng sau mũi 3',
              ],
            ),
            VaccinationSchedule(
              ageGroup: 'Trẻ 7 tháng tuổi đến dưới 1 tuổi',
              doses: [
                'Mũi 1: Lần tiêm đầu tiên',
                'Mũi 2: 1 tháng sau mũi 1',
                'Mũi 3: 6 tháng sau mũi 2',
              ],
            ),
            VaccinationSchedule(
              ageGroup: 'Trẻ 1 tuổi đến dưới 6 tuổi',
              doses: ['Mũi 1: Lần tiêm đầu tiên', 'Mũi 2: 2 tháng sau mũi 1'],
            ),
          ],
          administrationRoute: 'Tiêm bắp tay',
          contraindications: [
            'Phụ nữ có thai',
            'Người có tiền sử dị ứng nặng',
            'Bệnh nhân mắc bệnh thể ẩn và trong giai đoạn dưỡng bệnh',
            'Người có bệnh lý nền nặng',
            'Người đang điều trị bằng thuốc ức chế miễn dịch',
            'Người đang điều trị bằng thuốc kháng virus',
            'Người có triệu chứng co giật trong vòng 1 năm trước khi tiêm chủng',
          ],
          storageCondition: '2-8°C, tránh ánh sáng',
          precautions: [
            'Không tiêm cho phụ nữ mang thai',
            'Có thể chảy máu nhẹ khi tiêm',
          ],
          sideEffects: ['Đau đầu', 'Chóng mặt', 'Ngứa tại chỗ tiêm'],
        ),
        Vaccine(
          id: 'v003',
          name: 'Vắc xin COVID-19 Pfizer',
          description:
              'Vắc xin Prevenar 13 (Bỉ) phòng các bệnh phế cầu khuẩn xâm lấn gây nguy hiểm cho trẻ em và người lớn như viêm phổi, viêm màng não, viêm tai giữa cấp tính, nhiễm khuẩn huyết (nhiễm trùng máu)… do phế cầu khuẩn Streptococcus Pneumoniae gây ra.',
          diseases: ['COVID-19'],
          ageRange: 'Trên 18 tuổi',
          price: 850000,
          importedDate: DateTime(2023, 11, 5),
          manufacturer: 'Pfizer-BioNTech (Mỹ-Đức)',
          imageUrl: 'assets/images/vaccine/vc1.jpg',
          vaccinationSchedules: [
            VaccinationSchedule(
              ageGroup: 'Trẻ 6 tuần tuổi đến dưới 7 tháng',
              doses: [
                'Mũi 1: Lần tiêm đầu tiên',
                'Mũi 2: 1 tháng sau mũi 1',
                'Mũi 3: 1 tháng sau mũi 2',
                'Mũi 4: 6 tháng sau mũi 3',
              ],
            ),
            VaccinationSchedule(
              ageGroup: 'Trẻ 7 tháng tuổi đến dưới 1 tuổi',
              doses: [
                'Mũi 1: Lần tiêm đầu tiên',
                'Mũi 2: 1 tháng sau mũi 1',
                'Mũi 3: 6 tháng sau mũi 2',
              ],
            ),
            VaccinationSchedule(
              ageGroup: 'Trẻ 1 tuổi đến dưới 6 tuổi',
              doses: ['Mũi 1: Lần tiêm đầu tiên', 'Mũi 2: 2 tháng sau mũi 1'],
            ),
          ],
          administrationRoute: 'Tiêm bắp',
          contraindications: [
            'Phụ nữ có thai',
            'Người có tiền sử dị ứng nặng',
            'Bệnh nhân mắc bệnh thể ẩn và trong giai đoạn dưỡng bệnh',
            'Người có bệnh lý nền nặng',
            'Người đang điều trị bằng thuốc ức chế miễn dịch',
            'Người đang điều trị bằng thuốc kháng virus',
            'Người có triệu chứng co giật trong vòng 1 năm trước khi tiêm chủng',
          ],
          storageCondition: '-90°C đến -60°C (trước khi pha)',
          sideEffects: ['Mệt mỏi', 'Đau cơ', 'Sốt nhẹ 1-2 ngày'],
        ),
        // Thêm các vắc xin khác...
      ];
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
            MaterialPageRoute(builder: (context) => const NavigationBottom()),
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
                  Material(
                    color: Color(0xFF2F8CD8),
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 37,
                        ),
                        child: Text(
                          'Thêm vào giỏ',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),

                  Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 37,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Color(0xFF2F8CD8),
                            width: 1.3,
                          ),
                        ),
                        child: Text(
                          'Đặt lịch tiêm',
                          style: TextStyle(color: Color(0xFF2F8CD8)),
                        ),
                      ),
                    ),
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
