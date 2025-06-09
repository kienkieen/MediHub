import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medihub_app/core/widgets/services_widgets/package_item.dart';
import 'package:medihub_app/main.dart';
import 'package:medihub_app/models/vaccine.dart';
import 'package:medihub_app/models/vaccine_package.dart';
import 'package:medihub_app/presentation/screens/services/appointment.dart';
import 'package:medihub_app/presentation/screens/services/vaccine_list.dart';
import 'package:provider/provider.dart';
import 'package:medihub_app/core/widgets/appbar.dart';
import 'package:medihub_app/core/widgets/login_widgets/button.dart';
import 'package:medihub_app/core/widgets/search_bar.dart';
import 'package:medihub_app/models/cart.dart';
import 'package:medihub_app/presentation/screens/services/vaccine_detail.dart';
import 'package:medihub_app/presentation/screens/home/navigation.dart';
import 'package:medihub_app/providers/cart_provider.dart';

class CartScreen extends StatefulWidget {
  final String? initialSearch;
  final bool isFromBookingScreen; // Tham số mới

  const CartScreen({
    super.key,
    this.initialSearch,
    this.isFromBookingScreen = false, // Mặc định là false
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<CartVaccineItem> _filteredCartItems = [];
  List<CartVaccinePackage> _listCartVaccinePackages = [];
  Map<String, bool> _expandedPackages = {};
  @override
  void initState() {
    super.initState();
    if (userLogin != null) {
      _loadCartItems();
    }

    if (widget.initialSearch != null && widget.initialSearch!.isNotEmpty) {
      _searchController.text = widget.initialSearch!;
      _applyFilters();
    }
  }

  void _loadCartItems() {
    setState(() {
      _filteredCartItems =
          Provider.of<CartProvider>(
            context,
            listen: false,
          ).getCart.vaccineItems;
      _listCartVaccinePackages =
          Provider.of<CartProvider>(
            context,
            listen: false,
          ).getCart.vaccinePackages;
      for (var package in _listCartVaccinePackages) {
        _expandedPackages[package.packageId] = false;
      }
    });
  }

  void _applyFilters() {
    final cart = Provider.of<CartProvider>(context, listen: false).getCart;
    setState(() {
      _filteredCartItems =
          cart.vaccineItems.where((cartItem) {
            final vaccine =
                allVaccines
                    .where((v) => v.id == cartItem.vaccineId)
                    .firstOrNull;
            if (_searchController.text.isNotEmpty &&
                !vaccine!.name.toLowerCase().contains(
                  _searchController.text.toLowerCase(),
                )) {
              return false;
            }
            return true;
          }).toList();
    });
  }

  void _toggleExpand(String packageKey) {
    setState(() {
      _expandedPackages[packageKey] = !_expandedPackages[packageKey]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppbarWidget(
        isBackButton: true,
        title: widget.isFromBookingScreen ? 'Chọn vắc xin' : 'Giỏ hàng',
        icon: Icons.home_rounded,
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
            color: Colors.blue,
            child: Search_Bar(
              controller: _searchController,
              hintText: 'Tìm trong giỏ hàng ...',
              onChanged: (value) => _applyFilters(),
              onClear: _applyFilters,
              onSubmitted: _applyFilters,
            ),
          ),
          Expanded(
            child:
                (_filteredCartItems.isEmpty && _listCartVaccinePackages.isEmpty)
                    ? _emptyContent()
                    : buildList(_filteredCartItems, _listCartVaccinePackages),

            // ListView(
            //   children: [
            //     if (_filteredCartItems.isEmpty &&
            //         _listCartVaccinePackages.isEmpty) ...[
            //       _emptyContent(),
            //     ] else ...[
            //       buildList(_filteredCartItems, _listCartVaccinePackages),
            //       if (_filteredCartItems.isNotEmpty)
            //         ..._filteredCartItems
            //             .map((item) => _buildVaccineCard(item))
            //             .toList(),
            //       if (_listCartVaccinePackages.isNotEmpty)
            //         ..._listCartVaccinePackages.map(
            //           (package) =>
            //               package.package.isActive
            //                   ? Padding(
            //                     padding: EdgeInsets.symmetric(
            //                       vertical: 4,
            //                       horizontal: 10,
            //                     ),
            //                     child: PackageItem(
            //                       img: package.package.imageUrl,
            //                       title: package.package.name,
            //                       price: package.package.totalPrice.toString(),
            //                       discount: package.package.discount.toString(),
            //                       packageKey: package.package.id,
            //                       vaccinePackage: package.package,
            //                       expandedPackages: _expandedPackages,
            //                       allVaccines: allVaccines,
            //                       onExpandToggle: _toggleExpand,
            //                       typeBooking: widget.isFromBookingScreen,
            //                       isFromBooking: true,
            //                       isFromCart: true,
            //                     ),
            //                   )
            //                   : const SizedBox.shrink(),
            //         ),
            //     ],
            //   ],
            // ),
            //       _filteredCartItems.isEmpty
            //           ? _emptyContent()
            //           : ListView.builder(
            //             itemCount: _filteredCartItems.length,
            //             itemBuilder:
            //                 (context, index) =>
            //                     _buildVaccineCard(_filteredCartItems[index]),
            //           ),
            // ),
            // if (_listCartVaccinePackages.isNotEmpty)
            //   Expanded(
            //     child: ListView.builder(
            //       itemCount: _listCartVaccinePackages.length,
            //       itemBuilder:
            //           (context, index) =>
            //               _listCartVaccinePackages[index].package.isActive
            //                   ? PackageItem(
            //                     img:
            //                         _listCartVaccinePackages[index]
            //                             .package
            //                             .imageUrl,
            //                     title:
            //                         _listCartVaccinePackages[index].package.name,
            //                     price:
            //                         _listCartVaccinePackages[index]
            //                             .package
            //                             .totalPrice
            //                             .toString(),
            //                     discount:
            //                         _listCartVaccinePackages[index]
            //                             .package
            //                             .discount
            //                             .toString(),
            //                     packageKey:
            //                         _listCartVaccinePackages[index].package.id,
            //                     vaccinePackage:
            //                         _listCartVaccinePackages[index].package,
            //                     expandedPackages: _expandedPackages,
            //                     allVaccines: allVaccines,
            //                     onExpandToggle: _toggleExpand,
            //                     typeBooking: true,
            //                   )
            //                   : const SizedBox.shrink(),
            //     ),
          ),
          // Chỉ hiển thị tổng tiền và nút đặt lịch nếu không phải từ BookingScreen
          if (!widget.isFromBookingScreen)
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Tổng tiền: ${NumberFormat.currency(locale: 'vi_VN', symbol: 'đ').format(cartProvider.getCart.totalCartPrice)}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 10),
                  PrimaryButton(
                    text: 'ĐẶT LỊCH TIÊM',
                    borderRadius: 40,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => const VaccinationBookingScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget buildList(
    List<CartVaccineItem> cartItems,
    List<CartVaccinePackage> cartPackages,
  ) {
    List<Vaccine> cvaccines = [];
    for (Vaccine i in allVaccines) {
      if (cartItems.any((item) => item.vaccineId == i.id)) {
        cvaccines.add(i);
      }
    }
    List<VaccinePackage> cvaccinePackages = [];
    for (VaccinePackage i in allVaccinePackages) {
      if (cartPackages.any((item) => item.packageId == i.id)) {
        cvaccinePackages.add(i);
      }
    }

    for (var package in cvaccinePackages) {
      _expandedPackages[package.id] = false;
    }
    return ListView(
      children: [
        if (cvaccines.isNotEmpty)
          ...cvaccines.map((item) => _buildVaccineCard(item)).toList(),
        if (cvaccinePackages.isNotEmpty)
          ...cvaccinePackages.map(
            (package) =>
                package.isActive
                    ? Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 10,
                      ),
                      child: PackageItem(
                        img: package.imageUrl,
                        title: package.name,
                        price: package.totalPrice.toString(),
                        discount: package.discount.toString(),
                        packageKey: package.id,
                        vaccinePackage: package,
                        expandedPackages: _expandedPackages,
                        allVaccines: allVaccines,
                        onExpandToggle: _toggleExpand,
                        typeBooking: widget.isFromBookingScreen,
                        isFromBooking: true,
                        isFromCart: true,
                      ),
                    )
                    : const SizedBox.shrink(),
          ),
      ],
    );
  }

  Widget _buildVaccineCard(Vaccine vaccine) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4),
      margin: EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: InkWell(
        onTap:
            widget.isFromBookingScreen
                ? () {
                  Navigator.pop(context, vaccine);
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
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    NumberFormat.currency(
                      locale: 'vi_VN',
                      symbol: 'đ',
                    ).format(vaccine.price),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),

                  widget.isFromBookingScreen
                      ? ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, vaccine);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Chọn',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                      : IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          Provider.of<CartProvider>(
                            context,
                            listen: false,
                          ).removeItem(vaccine.id);
                          setState(() {
                            _applyFilters();
                          });
                        },
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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/images/find_vaccie.png"),
            const SizedBox(height: 16),
            Text(
              widget.isFromBookingScreen
                  ? 'Giỏ hàng trống, vui lòng thêm vắc xin'
                  : 'Giỏ hàng của bạn đang trống',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.grey, width: 1.5),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VaccineListScreen()),
                );
              },
              child: Text(
                'Xem danh mục vắc xin',
                style: TextStyle(color: Colors.black),
              ),
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
