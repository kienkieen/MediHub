import 'package:flutter/material.dart';
import 'package:medihub_app/core/widgets/appbar.dart';
import 'package:medihub_app/main.dart';
import 'package:medihub_app/models/vaccine_package.dart';
import 'package:medihub_app/models/vaccine.dart';
import 'package:medihub_app/core/widgets/noti.dart';

class VaccinePackageScreen extends StatefulWidget {
  const VaccinePackageScreen({super.key});

  @override
  State<VaccinePackageScreen> createState() => _VaccinePackageScreenState();
}

class _VaccinePackageScreenState extends State<VaccinePackageScreen> {
  final Map<String, bool> _expandedPackages = {
    '6_thang': false,
    '12_thang': false,
    '24_thang': false,
    'tien_hoc_duong': false,
    'thanh_thieu_nien': false,
    'truong_thanh': false,
  };

  // Danh sách các gói vắc xin
  final List<VaccinePackage> _vaccinePackages = [
    VaccinePackage(
      id: '6_thang',
      name: 'Gói vắc xin cho trẻ 6 tháng',
      ageGroup: 'Từ 0 đến 6 tháng',
      description:
          'Việc tiêm vắc xin cho trẻ từ 0 đến 6 tháng tuổi là cực kỳ quan trọng vì hệ miễn dịch'
          'của trẻ ở độ tuổi này còn yếu và chưa phát triển đầy đủ. Tiêm vắc xin giúp bảo vệ trẻ'
          'khỏi các bệnh nguy hiểm, đặc biệt là những bệnh truyền nhiễm có thể gây tử vong hoặc'
          'để lại di chứng nghiêm trọng, như bạch hầu, ho gà, uốn ván, tiêu chảy, bệnh do phế cầu, bệnh cúm.',
      vaccineIds: ['vaccine1', 'vaccine2'],
      dosesByVaccine: {
        'vaccine1': 2, // Vaccine 1 cần 2 liều
        'vaccine2': 3, // Vaccine 2 cần 3 liều
      },
      totalPrice: 9161300,
      discount: 440000,
      imageUrl: 'assets/icons/vaccine_package/package1.png',
    ),
    VaccinePackage(
      id: '12_thang',
      name: 'Gói vắc xin cho trẻ 12 tháng',
      ageGroup: 'Từ 0 đến 12 tháng',
      description:
          'Việc tiêm vắc xin cho trẻ từ 0 đến 12 tháng tuổi là rất cần thiết vì hệ miễn dịch của'
          'trẻ trong giai đoạn này còn yếu, dễ bị tấn công bởi các bệnh truyền nhiễm nguy hiểm. '
          'Các loại vắc xin quan trọng như 6 trong 1, vắc xin cúm giúp phòng ngừa các bệnh có thể'
          'gây tử vong hoặc để lại di chứng nghiêm trọng, bảo vệ trẻ khỏi các biến chứng nặng nề do bệnh gây ra.',
      vaccineIds: ['vaccine3'],
      dosesByVaccine: {
        'vaccine3': 1, // Vaccine 3 cần 1 liều
      },
      totalPrice: 8550000,
      discount: 640000,
      imageUrl: 'assets/icons/vaccine_package/package2.png',
    ),
    VaccinePackage(
      id: '24_thang',
      name: 'Gói vắc xin cho trẻ 24 tháng',
      ageGroup: 'Từ 0 đến 24 tháng',
      description:
          'Việc tiêm vắc xin cho trẻ từ 0 đến 12 tháng tuổi là rất cần thiết vì hệ miễn dịch của'
          'trẻ trong giai đoạn này còn yếu, dễ bị tấn công bởi các bệnh truyền nhiễm nguy hiểm. '
          'Các loại vắc xin quan trọng như 6 trong 1, vắc xin cúm giúp phòng ngừa các bệnh có thể'
          'gây tử vong hoặc để lại di chứng nghiêm trọng, bảo vệ trẻ khỏi các biến chứng nặng nề do bệnh gây ra.',
      vaccineIds: ['vaccine1', 'vaccine2', 'vaccine3'],
      dosesByVaccine: {'vaccine1': 1, 'vaccine3': 3, 'vaccine2': 2},
      totalPrice: 12550000,
      discount: 1000000,
      imageUrl: 'assets/icons/vaccine_package/package3.png',
    ),
    VaccinePackage(
      id: 'tien_hoc_duong',
      name: 'Gói vắc xin cho trẻ tiền học đường (từ 3 - 9 tuổi)',
      ageGroup: 'Từ 3 đến 9 tuổi',
      description:
          'Việc tiêm vắc xin cho trẻ từ 0 đến 12 tháng tuổi là rất cần thiết vì hệ miễn dịch của'
          'trẻ trong giai đoạn này còn yếu, dễ bị tấn công bởi các bệnh truyền nhiễm nguy hiểm. '
          'Các loại vắc xin quan trọng như 6 trong 1, vắc xin cúm giúp phòng ngừa các bệnh có thể'
          'gây tử vong hoặc để lại di chứng nghiêm trọng, bảo vệ trẻ khỏi các biến chứng nặng nề do bệnh gây ra.',
      vaccineIds: [],
      dosesByVaccine: {},
      totalPrice: 12550000,
      discount: 1000000,
      imageUrl: 'assets/icons/vaccine_package/package4.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppbarWidget(isBackButton: true, title: 'Gói vắc xin'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children:
              _vaccinePackages.map((package) {
                return _buildPackageItem(
                  img: package.imageUrl,
                  title: package.name,
                  price: package.totalPrice.toString(),
                  discount: package.discount.toString(),
                  packageKey: package.id,
                );
              }).toList(),
        ),
      ),
    );
  }

  Widget _buildPackageItem({
    required String img,
    required String title,
    required String price,
    required String discount,
    required String packageKey,
  }) {
    final double newPrice = double.parse(price) - double.parse(discount);
    return Container(
      margin: const EdgeInsets.only(bottom: 7),
      height: _expandedPackages[packageKey]! ? null : 87,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                setState(() {
                  _expandedPackages[packageKey] =
                      !_expandedPackages[packageKey]!;
                });
              },
              child: SizedBox(
                height: 85,
                child: Row(
                  children: [
                    Image.asset(img, width: 82, height: 82, fit: BoxFit.cover),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'Giảm còn ${newPrice.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}đ',
                              style: TextStyle(
                                color: Colors.red[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(
                        _expandedPackages[packageKey]!
                            ? Icons.expand_less
                            : Icons.expand_more,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_expandedPackages[packageKey]!)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _buildListVaccine(packageKey),
            ),
        ],
      ),
    );
  }

  Widget _buildListVaccine(String packageKey) {
    final package = _vaccinePackages.firstWhere(
      (package) => package.id == packageKey,
      orElse:
          () => VaccinePackage(
            id: 'unknown',
            name: 'Không xác định',
            ageGroup: 'Không xác định',
            description: 'Không có thông tin',
            vaccineIds: [],
            dosesByVaccine: {},
            totalPrice: 0,
            discount: 0,
            imageUrl: '',
          ),
    );

    if (package.id == 'unknown') {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text('Không tìm thấy thông tin gói.'),
      );
    }

    // Lấy danh sách vaccine từ allVaccines dựa trên vaccineIds của package
    final vaccines = package.getVaccines(allVaccines);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(color: Colors.grey[300], height: 1),
          const SizedBox(height: 8),
          Text(
            'Các loại vắc xin:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),

          ...vaccines.map(
            (vaccine) => Container(
              padding: EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Phòng bệnh: ${vaccine.diseases.join(', ')}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    '${vaccine.price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}đ',
                    style: TextStyle(
                      color: Colors.red[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Text(
            'LƯU Ý',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
          ),
          const SizedBox(height: 8),
          const Text(
            'Để xem thông tin chi tiết và tùy chỉnh gói tiêm phù hợp với nhu cầu, quý khách có thể nhấn vào nút "Chi tiết gói tiêm".',
            style: TextStyle(fontSize: 13),
          ),
          const SizedBox(height: 4),
          const Text(
            'Giá tạm tính từng loại vắc xin đã bao gồm 10% phí lưu trữ...',
            style: TextStyle(fontSize: 13),
          ),
          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Material(
                color: const Color(0xFF2F8CD8),
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => VaccinePackageDetailScreen(
                              package:
                                  package, // Truyền toàn bộ đối tượng VaccinePackage
                            ),
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                    child: Text(
                      'Chi tiết gói tiêm',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  onTap: () {
                    // Xử lý đặt lịch tiêm
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 35,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFF2F8CD8),
                        width: 1.3,
                      ),
                    ),
                    child: const Text(
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
    );
  }
}

class VaccinePackageDetailScreen extends StatefulWidget {
  final VaccinePackage package;

  const VaccinePackageDetailScreen({super.key, required this.package});

  @override
  State<VaccinePackageDetailScreen> createState() =>
      _VaccinePackageDetailScreenState();
}

class _VaccinePackageDetailScreenState
    extends State<VaccinePackageDetailScreen> {
  final Map<String, bool> _selectedVaccines = {};
  final Map<String, int> _vaccineQuantities = {};

  @override
  void initState() {
    super.initState();

    // Khởi tạo _selectedVaccines và _vaccineQuantities từ package
    for (var vaccineId in widget.package.vaccineIds) {
      _selectedVaccines[vaccineId] = true; // Mặc định chọn tất cả vaccine
      _vaccineQuantities[vaccineId] =
          widget.package.dosesByVaccine[vaccineId] ?? 1; // Số liều mặc định
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppbarWidget(isBackButton: true, title: widget.package.name),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BuildNoti(
              content:
                  'LƯU Ý: Phải đặt đủ tất cả vắc xin trong gói mới được áp dụng giảm giá.',
              icon: Icons.error_outline,
            ),
            _buildPackageHeader(widget.package.imageUrl),
            const SizedBox(height: 7),

            // Đối tượng tiêm
            _buildTargetGroupSection(),
            const SizedBox(height: 7),

            // Danh sách vắc xin
            _buildVaccineList(),

            const SizedBox(height: 24),
            _buildSummarySection(),
          ],
        ),
      ),
    );
  }

  Widget _buildPackageHeader(String img) {
    final double newPrice = widget.package.totalPrice - widget.package.discount;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.package.name,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold, fontSize: 21),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${newPrice.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')} đ / gói',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Text(
                          '${widget.package.totalPrice.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')} đ',
                          style: const TextStyle(
                            fontSize: 14,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 180,
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 3,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.orange.shade300,
                            Colors.orange.shade600,
                            Colors.orange.shade800,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.bolt, color: Colors.white),
                          Text(
                            'Giảm tới ${widget.package.discount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')} đ',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 5),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 100,
                height: 100,
                child: Image.asset(
                  img,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFFE6F1F8),
              borderRadius: BorderRadius.circular(8),
            ),
            child: SizedBox(
              child: Text.rich(
                TextSpan(
                  children: [
                    WidgetSpan(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Image.asset(
                          'assets/icons/vaccine_package/light.png',
                          width: 16,
                          height: 16,
                        ),
                      ),
                    ),
                    TextSpan(
                      text:
                          'Giá tạm tính đã bao gồm 10% phí lưu trữ cho tất cả các mũi, '
                          'giá thực tế tại trung tâm sẽ rõ hơn phụ thuộc vào những mũi tiêm '
                          'ngay không có phí lưu trữ và giá khuyến mãi tại shop theo từng thời điểm.',
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTargetGroupSection() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Đối tượng tiêm',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('Từ 0 tuổi đến 6 tháng', style: TextStyle(fontSize: 14)),
          const SizedBox(height: 12),
          Text(widget.package.description, style: TextStyle(fontSize: 14)),
          const Divider(height: 40),
        ],
      ),
    );
  }

  Widget _buildVaccineItem({
    required String disease,
    required String name,
    required String dose,
    required int originalPrice,
    required int pricePrice,
    required bool isSelected,
    required ValueChanged<bool> onChanged,
  }) {
    // Chuyển đổi dose từ chuỗi sang số nguyên
    final int doseCount = int.tryParse(dose.split(' ')[0]) ?? 1;

    // Tính tổng giá
    final int totalPrice = pricePrice * doseCount;

    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(bottom: BorderSide(color: Colors.grey)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Checkbox(
                  value: isSelected,
                  onChanged: (value) => onChanged(value ?? false),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Phòng bệnh $disease',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 48),
              child: Text(name, style: const TextStyle(fontSize: 15)),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 48),
              child: Row(
                children: [
                  Text(dose, style: const TextStyle(fontSize: 14)),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _formatPrice(totalPrice),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (pricePrice != originalPrice)
                        Text(
                          _formatPrice(originalPrice * doseCount),
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVaccineList() {
    final vaccines = widget.package.getVaccines(allVaccines);

    return Container(
      margin: const EdgeInsets.all(7),
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 17, 89, 148),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DANH SÁCH VẮC XIN',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children:
                  vaccines.map((vaccine) {
                    return _buildVaccineItem(
                      disease: vaccine.diseases.join(', '),
                      name: vaccine.name,
                      dose:
                          '${widget.package.dosesByVaccine[vaccine.id] ?? 1} liều',
                      originalPrice: vaccine.price.toInt(),
                      pricePrice: vaccine.price.toInt(),
                      isSelected: _selectedVaccines[vaccine.id] ?? false,
                      onChanged: (value) {
                        setState(() {
                          _selectedVaccines[vaccine.id] = value;
                        });
                      },
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummarySection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Column(
        children: [
          _buildTotalRow('Tổng tạm tính:', _calculateTotal()),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Xử lý đặt lịch tiêm
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[700],
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'ĐẶT LỊCH TIÊM NGAY',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalRow(String label, int amount) {
    return Row(
      children: [
        Text(label, style: const TextStyle(fontSize: 15)),
        const Spacer(),
        Text(
          _formatPrice(amount),
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: label.contains('Tiết kiệm') ? Colors.red : Colors.black,
          ),
        ),
      ],
    );
  }

  String _formatPrice(int price) {
    return '${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (match) => '${match[1]}.')}đ';
  }

  int _calculateTotal() {
    int total = 0;

    _selectedVaccines.forEach((key, isSelected) {
      if (isSelected) {
        final quantity = _vaccineQuantities[key] ?? 1;

        // Tìm vaccine trong danh sách allVaccines
        final vaccine = allVaccines!.firstWhere(
          (v) => v.id.toLowerCase() == key.toLowerCase(),
          orElse:
              () => Vaccine(
                id: '',
                name: '',
                description: '',
                diseases: [],
                ageRange: '',
                price: 0,
                importedDate: DateTime.now(),
                manufacturer: '',
                imageUrl: '',
                vaccinationSchedules: [],
                administrationRoute: '',
                contraindications: [],
                storageCondition: '',
              ),
        );

        // Tính tổng giá
        total += (vaccine.price.toInt() * quantity);
      }
    });

    return total;
  }
}
