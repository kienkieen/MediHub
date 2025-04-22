import 'package:flutter/material.dart';
import 'package:medihub_app/core/widgets/appbar.dart';
import 'package:medihub_app/core/widgets/search_bar.dart';
import 'package:medihub_app/core/widgets/filter_vaccine_list.dart';
import 'package:medihub_app/core/widgets/filterchip.dart';
import 'package:medihub_app/core/ultils/constants.dart';
import 'package:medihub_app/models/vaccine.dart';
import 'package:medihub_app/presentation/screens/services/vaccine_detail.dart';
import 'package:medihub_app/presentation/screens/home/navigation.dart';

class VaccineListScreen extends StatefulWidget {
  final String? initialSearch;
  const VaccineListScreen({super.key, this.initialSearch});
  @override
  State<VaccineListScreen> createState() => _VaccineListScreenState();
}

class _VaccineListScreenState extends State<VaccineListScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Vaccine> _vaccines = [];
  List<Vaccine> _filteredVaccines = [];
  FilterOptions _filterOptions = FilterOptions();

  @override
  void initState() {
    super.initState();
    _loadVaccines();

    if (widget.initialSearch != null && widget.initialSearch!.isNotEmpty) {
      _searchController.text = widget.initialSearch!;
      _applyFilters();
    }
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

  void _applyFilters() {
    setState(() {
      _filteredVaccines =
          _vaccines.where((vaccine) {
            // Lọc theo tìm kiếm
            if (_searchController.text.isNotEmpty &&
                !vaccine.name.toLowerCase().contains(
                  _searchController.text.toLowerCase(),
                )) {
              return false;
            }

            // Lọc theo tuổi
            if (_filterOptions.ageRange != null) {
              if (vaccine.ageRange != _filterOptions.ageRange) {
                return false;
              }
            }

            // Lọc theo bệnh
            if (_filterOptions.diseases.isNotEmpty &&
                !_filterOptions.diseases.any(
                  (d) => vaccine.diseases.contains(d),
                )) {
              return false;
            }

            // Lọc theo giá
            if (vaccine.price < _filterOptions.minPrice ||
                vaccine.price > _filterOptions.maxPrice) {
              return false;
            }

            // Lọc theo nơi sản xuất
            if (_filterOptions.manufacturers.isNotEmpty &&
                !_filterOptions.manufacturers.contains(vaccine.manufacturer)) {
              return false;
            }

            // Lọc theo ngày nhập
            if (_filterOptions.importDateRange != null &&
                (vaccine.importedDate.isBefore(
                      _filterOptions.importDateRange!.start,
                    ) ||
                    vaccine.importedDate.isAfter(
                      _filterOptions.importDateRange!.end,
                    ))) {
              return false;
            }

            // Lọc theo quan tâm
            if (_filterOptions.onlyPopular && !vaccine.isPopular) {
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
        title: 'Danh mục vắc xin',
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

          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade400, width: 1),
              ),
              color: Colors.white,
            ),
            height: 57,
            child: Row(
              children: [
                InkWell(
                  onTap: () async {
                    final options = await showModalBottomSheet<FilterOptions>(
                      context: context,
                      isScrollControlled: true,
                      builder:
                          (context) =>
                              FilterSheet(initialOptions: _filterOptions),
                    );
                    if (options != null) {
                      setState(() {
                        _filterOptions = options;
                        _applyFilters();
                      });
                    }
                  },
                  child: Container(
                    height: 57,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: Colors.grey.shade400,
                          width: 1,
                        ),
                      ),
                      color: Colors.transparent,
                    ),

                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        Image.asset(
                          "assets/icons/filter.gif",
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(width: 7),
                        Text('Bộ Lọc'),
                        SizedBox(width: 10),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),

                Expanded(child: _buildCategoryButtons()), // Thêm Expanded
              ],
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

  Widget _buildCategoryButtons() {
    const categories = ['Tất cả', 'Trẻ em', 'Người lớn'];
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder:
            (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7.0),
              child: CustomFilterChip(
                label: categories[index],
                isSelected: _filterOptions.category == categories[index],
                onSelected: (selected) {
                  setState(() {
                    _filterOptions.category =
                        selected ? categories[index] : null;
                    _applyFilters();
                  });
                },
              ),
            ),
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
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
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
