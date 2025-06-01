import 'package:flutter/material.dart';
import 'package:medihub_app/main.dart';
import 'package:medihub_app/models/vaccine_package.dart';
import 'package:provider/provider.dart';
import 'package:medihub_app/core/widgets/appbar.dart';
import 'package:medihub_app/core/widgets/search_bar.dart';
import 'package:medihub_app/core/widgets/services_widgets/filter_vaccine_list.dart';
import 'package:medihub_app/core/widgets/services_widgets/filterchip.dart';

import 'package:medihub_app/models/vaccine.dart';
import 'package:medihub_app/core/widgets/services_widgets/package_item.dart';
import 'package:medihub_app/presentation/screens/services/vaccine_detail.dart';
import 'package:medihub_app/presentation/screens/home/navigation.dart';
import 'package:medihub_app/presentation/screens/services/cart.dart';
import 'package:medihub_app/providers/cart_provider.dart';
import 'package:medihub_app/core/widgets/button2.dart';

class VaccineListScreen extends StatefulWidget {
  final String? initialSearch;
  final bool isFromBookingScreen; // Tham số mới

  const VaccineListScreen({
    super.key,
    this.initialSearch,
    this.isFromBookingScreen = false, // Mặc định là false
  });

  @override
  State<VaccineListScreen> createState() => _VaccineListScreenState();
}

class _VaccineListScreenState extends State<VaccineListScreen> {
  Map<String, bool> _expandedPackages = {};
  final TextEditingController _searchController = TextEditingController();
  List<Vaccine> _vaccines = [];
  List<VaccinePackage> _vaccinePackages = [];
  List<Vaccine> _filteredVaccines = [];
  bool isState = true;
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

  void _toggleExpand(String packageKey) {
    setState(() {
      _expandedPackages[packageKey] = !_expandedPackages[packageKey]!;
    });
  }

  void _loadVaccines() {
    setState(() {
      _vaccines = allVaccines;
      _filteredVaccines = _vaccines;
      if (widget.isFromBookingScreen) {
        _vaccinePackages = allVaccinePackages;
        for (var package in _vaccinePackages) {
          Map<String, bool> packageState = {package.id: false};
          setState(() {
            _expandedPackages.addAll(packageState);
          });
        }
      }
    });
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
            if (_filterOptions.ageRange != null) {
              if (vaccine.ageRange != _filterOptions.ageRange) {
                return false;
              }
            }
            if (_filterOptions.diseases.isNotEmpty &&
                !_filterOptions.diseases.any(
                  (d) => vaccine.diseases.contains(d),
                )) {
              return false;
            }
            if (vaccine.price < _filterOptions.minPrice ||
                vaccine.price > _filterOptions.maxPrice) {
              return false;
            }
            if (_filterOptions.manufacturers.isNotEmpty &&
                !_filterOptions.manufacturers.contains(vaccine.manufacturer)) {
              return false;
            }
            if (_filterOptions.importDateRange != null &&
                (vaccine.importedDate.isBefore(
                      _filterOptions.importDateRange!.start,
                    ) ||
                    vaccine.importedDate.isAfter(
                      _filterOptions.importDateRange!.end,
                    ))) {
              return false;
            }
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
        isBackButton: true,
        title: widget.isFromBookingScreen ? 'Chọn vắc xin' : 'Danh mục vắc xin',
        icon:
            widget.isFromBookingScreen
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
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 5),
            color: Colors.blue,
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
                if (!widget.isFromBookingScreen)
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
                          const SizedBox(width: 10),
                          Image.asset(
                            "assets/icons/filter.gif",
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(width: 7),
                          const Text('Bộ Lọc'),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(width: 10),
                if (widget.isFromBookingScreen)
                  Expanded(child: _buildCategoryButtons()),
              ],
            ),
          ),
          Expanded(
            child:
                isState
                    ? _filteredVaccines.isEmpty
                        ? _emptyContent()
                        : ListView.builder(
                          itemCount: _filteredVaccines.length,
                          itemBuilder:
                              (context, index) =>
                                  _buildVaccineCard(_filteredVaccines[index]),
                        )
                    : _vaccinePackages.length > 0
                    ? Padding(
                      padding: const EdgeInsets.all(8),
                      child: ListView.builder(
                        itemCount: _vaccinePackages.length,
                        itemBuilder:
                            (context, index) =>
                                _vaccinePackages[index].isActive
                                    ? PackageItem(
                                      img: _vaccinePackages[index].imageUrl,
                                      title: _vaccinePackages[index].name,
                                      price:
                                          _vaccinePackages[index].totalPrice
                                              .toString(),
                                      discount:
                                          _vaccinePackages[index].discount
                                              .toString(),
                                      packageKey: _vaccinePackages[index].id,
                                      vaccinePackage: _vaccinePackages[index],
                                      expandedPackages: _expandedPackages,
                                      allVaccines: allVaccines,
                                      onExpandToggle: _toggleExpand,
                                      typeBooking: true,
                                      isFromBooking: true,
                                    )
                                    : const SizedBox.shrink(),
                      ),
                    )
                    : _emptyContent(),
            // : Padding(
            //   padding: const EdgeInsets.all(8),
            //   child:

            //   // Column(
            //   //   children:
            //   //       _vaccinePackages.map((package) {
            //   //         return PackageItem(
            //   //           img: package.imageUrl,
            //   //           title: package.name,
            //   //           price: package.totalPrice.toString(),
            //   //           discount: package.discount.toString(),
            //   //           packageKey: package.id,
            //   //           vaccinePackages: allVaccinePackages,
            //   //           expandedPackages: _expandedPackages,
            //   //           allVaccines: allVaccines,
            //   //           onExpandToggle: _toggleExpand,
            //   //         );
            //   //       }).toList(),
            //   // ),
            // ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButtons() {
    var categories = ['Vắc xin', 'Gói vắc xin'];
    if (_filterOptions.category == null && isState) {
      _filterOptions.category = categories[0];
    }
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
                    if (_filterOptions.category != categories[index]) {
                      _filterOptions.category = categories[index];

                      if (_filterOptions.category == categories[0]) {
                        isState = true;
                      } else if (_filterOptions.category == categories[1]) {
                        isState = false;
                      }
                      _applyFilters();
                    }
                  });
                },
              ),
            ),
      ),
    );
  }

  Widget _buildVaccineCard(Vaccine vaccine) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: InkWell(
        onTap:
            widget.isFromBookingScreen
                ? () {
                  Navigator.pop(context, vaccine); // Trả về vắc xin khi nhấn
                }
                : () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VaccineDetailPage(vaccine: vaccine),
                  ),
                ),
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
              if (!widget.isFromBookingScreen) const SizedBox(height: 10),
              if (!widget.isFromBookingScreen)
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
              if (widget.isFromBookingScreen)
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, vaccine);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(190, 40),
                      backgroundColor: const Color(0xFF2F8CD8),
                    ),
                    child: const Text(
                      'Chọn',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ),
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
            Text(
              widget.isFromBookingScreen
                  ? 'Không có vắc xin nào, vui lòng thử lại'
                  : 'Không tìm thấy vắc xin nào',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
