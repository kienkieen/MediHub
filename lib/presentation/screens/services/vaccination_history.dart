import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart'; // Để sử dụng groupBy
import 'package:medihub_app/core/widgets/appbar.dart';
import 'package:medihub_app/core/widgets/search_bar.dart';
import 'package:medihub_app/core/widgets/services_widgets/filterchip.dart';
import 'package:medihub_app/core/widgets/services_widgets/package_item.dart';
import 'package:medihub_app/firebase_helper/VaccinationRecord_helper.dart';
import 'package:medihub_app/main.dart';
import 'package:medihub_app/models/vaccine.dart';
import 'package:medihub_app/models/vaccinePackage_record.dart';
import 'package:medihub_app/presentation/screens/home/navigation.dart';
import 'package:medihub_app/models/vaccine_record.dart';
import 'package:medihub_app/presentation/screens/login/login.dart';

class VaccinationHistoryScreen extends StatefulWidget {
  const VaccinationHistoryScreen({super.key});

  @override
  State<VaccinationHistoryScreen> createState() =>
      _VaccinationHistoryScreenState();
}

class _VaccinationHistoryScreenState extends State<VaccinationHistoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  List<VaccinationRecord> _records = [];
  List<VaccinationRecord> _filteredRecords = [];
  List<VaccinePackageRecord> _vaccinePackageRecords = [];
  bool isState = true;
  Map<String, bool> _expandedPackages = {};
  FilterOptions _filterOptions = FilterOptions();

  void _toggleExpand(String packageKey) {
    setState(() {
      _expandedPackages[packageKey] = !_expandedPackages[packageKey]!;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadRecords();
    _searchController.addListener(_applyFilters);
    _filterOptions.category = 'Vắc xin';
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (userLogin == null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(isNewLoginl: false),
          ),
        );
      }
    });
  }

  void _loadRecords() async {
    _records = await getVaccinationRecords(useMainLogin!.userId);
    _vaccinePackageRecords = await getVaccinePackageRecords(
      useMainLogin!.userId,
    );

    for (var record in _vaccinePackageRecords) {
      _expandedPackages[record.vaccinePackage.id] = false;
    }
    setState(() {
      _filteredRecords = _records;
    });
  }

  void _applyFilters() {
    setState(() {
      _filteredRecords =
          _records.where((record) {
            // Lọc theo tên vắc xin
            if (_searchController.text.isNotEmpty &&
                !record.vaccine.name.toLowerCase().contains(
                  _searchController.text.toLowerCase(),
                )) {
              return false;
            }
            // Lọc theo khoảng ngày
            final fromDate =
                _fromDateController.text.isNotEmpty
                    ? DateFormat('dd/MM/yyyy').parse(_fromDateController.text)
                    : DateTime(2000);
            final toDate =
                _toDateController.text.isNotEmpty
                    ? DateFormat('dd/MM/yyyy').parse(_toDateController.text)
                    : DateTime.now();
            if (record.date.isBefore(fromDate) || record.date.isAfter(toDate)) {
              return false;
            }
            return true;
          }).toList();
    });
  }

  Future<void> _selectDate(
    BuildContext context,
    TextEditingController controller, {
    bool isFromDate = true,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          controller.text.isNotEmpty
              ? DateFormat('dd/MM/yyyy').parse(controller.text)
              : DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(primary: Colors.blue),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('dd/MM/yyyy').format(picked);
        _applyFilters();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final groupedRecords = groupBy(
      _filteredRecords,
      (VaccinationRecord record) =>
          DateFormat('dd/MM/yyyy').format(record.date),
    );
    final groupedPackageRecords = groupBy(
      _vaccinePackageRecords,
      (VaccinePackageRecord record) =>
          DateFormat('dd/MM/yyyy').format(record.date),
    );

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppbarWidget(isBackButton: true, title: 'Lịch Sử Tiêm Chủng'),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 5),
            color: Colors.blue,
            child: Search_Bar(
              controller: _searchController,
              hintText: 'Tìm theo tên vắc xin...',
              onChanged: (value) => _applyFilters(),
              onClear: _applyFilters,
              onSubmitted: _applyFilters,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectDate(context, _fromDateController),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade500),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _fromDateController.text.isEmpty
                                ? 'Từ ngày'
                                : _fromDateController.text,
                            style: TextStyle(
                              color:
                                  _fromDateController.text.isEmpty
                                      ? Colors.grey
                                      : Colors.black,
                            ),
                          ),
                          const Icon(Icons.calendar_today),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 30),
                Expanded(
                  child: GestureDetector(
                    onTap:
                        () => _selectDate(
                          context,
                          _toDateController,
                          isFromDate: false,
                        ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade500),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _toDateController.text.isEmpty
                                ? 'Đến ngày'
                                : _toDateController.text,
                            style: TextStyle(
                              color:
                                  _toDateController.text.isEmpty
                                      ? Colors.grey
                                      : Colors.black,
                            ),
                          ),
                          const Icon(Icons.calendar_today),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.white,
            child: _buildCategoryButtons(),
          ),
          Expanded(
            child:
                isState
                    ? _filteredRecords.isEmpty
                        ? _emptyContent()
                        : ListView.builder(
                          itemCount: groupedRecords.keys.length,
                          itemBuilder: (context, index) {
                            final date = groupedRecords.keys.elementAt(index);
                            final recordsForDate = groupedRecords[date]!;
                            return Container(
                              margin: const EdgeInsets.only(top: 10),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(color: Colors.white),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.grey.shade400,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    padding: const EdgeInsets.only(bottom: 8),
                                    margin: const EdgeInsets.all(10),
                                    child: Text(
                                      date,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: recordsForDate.length,
                                    itemBuilder:
                                        (context, recordIndex) =>
                                            _buildRecordCard(
                                              recordsForDate[recordIndex],
                                            ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                    : _vaccinePackageRecords.isEmpty
                    ? _emptyContent()
                    : ListView.builder(
                      itemCount: groupedPackageRecords.keys.length,
                      itemBuilder: (context, index) {
                        final date = groupedPackageRecords.keys.elementAt(
                          index,
                        );
                        final recordsForDate = groupedPackageRecords[date]!;
                        return Container(
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(color: Colors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey.shade400,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                padding: const EdgeInsets.only(bottom: 8),
                                margin: const EdgeInsets.all(10),
                                child: Text(
                                  date,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: recordsForDate.length,
                                itemBuilder:
                                    (context, recordIndex) => PackageItem(
                                      img:
                                          recordsForDate[recordIndex]
                                              .vaccinePackage
                                              .imageUrl,
                                      title:
                                          recordsForDate[recordIndex]
                                              .vaccinePackage
                                              .name,
                                      price:
                                          recordsForDate[recordIndex]
                                              .vaccinePackage
                                              .totalPrice
                                              .toString(),
                                      discount:
                                          recordsForDate[recordIndex]
                                              .vaccinePackage
                                              .discount
                                              .toString(),
                                      packageKey:
                                          recordsForDate[recordIndex]
                                              .vaccinePackage
                                              .id,
                                      vaccinePackage:
                                          recordsForDate[recordIndex]
                                              .vaccinePackage,
                                      expandedPackages: _expandedPackages,
                                      allVaccines: allVaccines,
                                      onExpandToggle: _toggleExpand,
                                      typeBooking: true,
                                      isFormBooking: false,
                                    ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

            // ListView.builder(
            //   itemCount: _vaccinePackageRecords.length,
            //   itemBuilder:
            //       (context, index) =>
            //           _vaccinePackageRecords[index]
            //                   .vaccinePackage
            //                   .isActive
            //               ? PackageItem(
            //                 img:
            //                     _vaccinePackageRecords[index]
            //                         .vaccinePackage
            //                         .imageUrl,
            //                 title:
            //                     _vaccinePackageRecords[index]
            //                         .vaccinePackage
            //                         .name,
            //                 price:
            //                     _vaccinePackageRecords[index]
            //                         .vaccinePackage
            //                         .totalPrice
            //                         .toString(),
            //                 discount:
            //                     _vaccinePackageRecords[index]
            //                         .vaccinePackage
            //                         .discount
            //                         .toString(),
            //                 packageKey:
            //                     _vaccinePackageRecords[index]
            //                         .vaccinePackage
            //                         .id,
            //                 vaccinePackage:
            //                     _vaccinePackageRecords[index]
            //                         .vaccinePackage,
            //                 expandedPackages: _expandedPackages,
            //                 allVaccines: allVaccines,
            //                 onExpandToggle: _toggleExpand,
            //                 typeBooking: true,
            //                 isFormBooking: false,
            //               )
            //               : const SizedBox.shrink(),
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

  Widget _buildRecordCard(VaccinationRecord record) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade400, width: 1),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Xem chi tiết: ${record.vaccine.name}'),
              duration: const Duration(seconds: 2),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset(
                  record.vaccine.imageUrl.isNotEmpty
                      ? record.vaccine.imageUrl
                      : 'assets/images/vaccine/default.jpg',
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      record.vaccine.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Ngày tiêm: ${DateFormat('dd/MM/yyyy').format(record.date)}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    Text(
                      'Liều: ${record.dose}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    Text(
                      'Nơi tiêm: ${record.location}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emptyContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 50),
          Image.asset("assets/images/find_vaccie.png", width: 250, height: 250),
          const Text(
            'Không có lịch sử tiêm chủng',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const NavigationBottom(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              side: BorderSide(color: Colors.grey, width: 1.5),
            ),
            child: const Text(
              'Quay về trang chủ',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _fromDateController.dispose();
    _toDateController.dispose();
    super.dispose();
  }
}
