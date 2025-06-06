import 'package:flutter/material.dart';
import 'package:medihub_app/core/widgets/appbar.dart';
import 'package:medihub_app/core/widgets/services_widgets/package_item.dart';
//import 'package:medihub_app/main.dart';
import 'package:medihub_app/models/vaccine_package.dart';
import 'package:medihub_app/models/vaccine.dart';
import 'package:medihub_app/core/widgets/noti.dart';
import 'package:medihub_app/presentation/screens/services/cart.dart';
import 'package:medihub_app/presentation/screens/home/navigation.dart';
import 'package:medihub_app/core/widgets/login_widgets/button.dart';
import 'package:medihub_app/firebase_helper/vaccinePackage_helper.dart';
import 'package:medihub_app/firebase_helper/vaccine_helper.dart';

class VaccinePackageScreen extends StatefulWidget {
  final bool isFromBookingScreen;
  const VaccinePackageScreen({super.key, this.isFromBookingScreen = false});

  @override
  State<VaccinePackageScreen> createState() => _VaccinePackageScreenState();
}

class _VaccinePackageScreenState extends State<VaccinePackageScreen> {
  Map<String, bool> _expandedPackages = {};
  List<VaccinePackage> _vaccinePackages = [];
  List<Vaccine> _allVaccines = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadVaccinePackages();
    });
  }

  void _toggleExpand(String packageKey) {
    setState(() {
      _expandedPackages[packageKey] = !_expandedPackages[packageKey]!;
    });
  }

  Future<void> _loadVaccinePackages() async {
    try {
      setState(() {
        _isLoading = true;
      });

      // Load both vaccine packages and vaccines from Firebase
      final packagesData = await getAllVaccinePackage();
      final vaccinesData = await loadAllVaccines();

      setState(() {
        _vaccinePackages = packagesData;
        _allVaccines = vaccinesData;
        _isLoading = false;
      });

      // Initialize expanded state for each package
      for (var package in _vaccinePackages) {
        _expandedPackages[package.id] = false;
      }

    } catch (e) {
      print('Error loading vaccine packages: $e');
      setState(() {
        _isLoading = false;
      });
      
      // Show error message to user
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lỗi khi tải dữ liệu gói vắc xin: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _refreshData() async {
    try {
      // Reload data from Firebase
      await _loadVaccinePackages();
      
      // if (mounted) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //       content: Text('Dữ liệu đã được cập nhật'),
      //       backgroundColor: Colors.green,
      //     ),
      //   );
      // }
    } catch (e) {
      print('Error refreshing data: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lỗi khi làm mới dữ liệu: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppbarWidget(
        isBackButton: true,
        title: 'Gói vắc xin',
        icon: widget.isFromBookingScreen
            ? Icons.home_rounded
            : Icons.shopping_bag_outlined,
        onPressed: () {
          if (widget.isFromBookingScreen) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NavigationBottom()),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartScreen()),
            );
          }
        },
      ),
      body: _isLoading
          ? _loadingContent()
          : _vaccinePackages.isEmpty
              ? _emptyContent()
              : RefreshIndicator(
                  onRefresh: _refreshData,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: ListView.builder(
                      itemCount: _vaccinePackages.length,
                      itemBuilder: (context, index) =>
                          _vaccinePackages[index].isActive
                              ? PackageItem(
                                  img: _vaccinePackages[index].imageUrl,
                                  title: _vaccinePackages[index].name,
                                  price: _vaccinePackages[index]
                                      .totalPrice
                                      .toString(),
                                  discount: _vaccinePackages[index]
                                      .discount
                                      .toString(),
                                  packageKey: _vaccinePackages[index].id,
                                  vaccinePackage: _vaccinePackages[index],
                                  expandedPackages: _expandedPackages,
                                  allVaccines: _allVaccines,
                                  onExpandToggle: _toggleExpand,
                                  typeBooking: false,
                                  isFromBooking: false,
                                )
                              : const SizedBox.shrink(),
                    ),
                  ),
                ),
    );
  }

  Widget _loadingContent() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text(
            'Đang tải dữ liệu gói vắc xin...',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _emptyContent() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/images/find_vaccie.png"),
            const SizedBox(height: 16),
            const Text(
              'Không có gói vắc xin nào, vui lòng thử lại',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _refreshData,
              child: const Text('Thử lại'),
            ),
          ],
        ),
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
  List<Vaccine> _allVaccines = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadVaccines();
    });
  }

  Future<void> _loadVaccines() async {
    try {
      setState(() {
        _isLoading = true;
      });

      // Load vaccines from Firebase
      final vaccinesData = await loadAllVaccines();

      setState(() {
        _allVaccines = vaccinesData;
        _isLoading = false;
      });

      // Initialize selected vaccines and quantities from package
      for (var vaccineId in widget.package.vaccineIds) {
        _selectedVaccines[vaccineId] = true; // Default select all vaccines
        _vaccineQuantities[vaccineId] =
            widget.package.dosesByVaccine[vaccineId] ?? 1; // Default doses
      }

    } catch (e) {
      print('Error loading vaccines: $e');
      setState(() {
        _isLoading = false;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lỗi khi tải dữ liệu vắc xin: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppbarWidget(isBackButton: true, title: widget.package.name),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text(
                'Đang tải thông tin gói vắc xin...',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      );
    }

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
    final vaccines = widget.package.getVaccines(_allVaccines);

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
              children: vaccines.map((vaccine) {
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
          PrimaryButton(
            text: 'ĐẶT LỊCH TIÊM NGAY',
            borderRadius: 48,
            onPressed: () => {},
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

        // Tìm vaccine trong danh sách _allVaccines
        final vaccine = _allVaccines.firstWhere(
          (v) => v.id.toLowerCase() == key.toLowerCase(),
          orElse: () => Vaccine(
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