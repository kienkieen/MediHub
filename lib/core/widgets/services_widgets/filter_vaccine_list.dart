import 'package:flutter/material.dart';
import 'package:medihub_app/firebase_helper/vaccine_helper.dart';
import 'package:medihub_app/models/diseases.dart';
import 'package:medihub_app/models/supplier.dart';
import 'package:medihub_app/models/vaccine.dart';
import 'package:medihub_app/core/widgets/services_widgets/filterchip.dart';

class FilterSheet extends StatefulWidget {
  final FilterOptions initialOptions;

  const FilterSheet({super.key, required this.initialOptions});

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  late FilterOptions _options;
  List<Diseases> diseases = [];
  List<Supplier> manufacturers = [];

  // const diseases = [
  //     'Sởi',
  //     'Quai bị',
  //     'Viêm gan B',
  //     'HPV',
  //     'COVID-19',
  //     'Cúm',
  //     'Bạch hầu',
  //   ];

  // const manufacturers = [
  //     'Mỹ',
  //     'Pháp',
  //     'Nhật',
  //     'Hàn Quốc',
  //     'Việt Nam',
  //     'Ấn Độ',
  //   ];

  void fetchDiseases() async {
    final tmp = await loadDisease();
    setState(() {
      diseases = tmp;
    });
  }

  void fetchSuppliers() async {
    final tmp = await loadSupplier();
    setState(() {
      manufacturers = tmp;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchDiseases();
    fetchSuppliers();
    _options = widget.initialOptions;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      padding: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        children: [
          const Text(
            'Bộ lọc vắc xin',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAgeFilter(),
                  _buildDiseaseFilter(),
                  _buildPriceFilter(),
                  _buildManufacturerFilter(),
                  _buildDateFilter(),
                  _buildPopularFilter(),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Hủy'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, _options),
                  child: const Text('Áp dụng'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAgeFilter() {
    const ageRanges = ['0-1 tuổi', '1-5 tuổi', '6-18 tuổi', 'Trên 18 tuổi'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Độ tuổi',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Wrap(
          spacing: 8,
          children:
              ageRanges.map((age) {
                return CustomFilterChip(
                  label: age,
                  isSelected: _options.ageRange == age,
                  onSelected: (selected) {
                    setState(() {
                      _options.ageRange = selected ? age : null;
                    });
                  },
                );
              }).toList(),
        ),
        const Divider(),
      ],
    );
  }

  Widget _buildDiseaseFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Bệnh',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Wrap(
          spacing: 8,
          children:
              diseases.map((disease) {
                return CustomFilterChip(
                  label: disease.name,
                  isSelected: _options.diseases.contains(disease.name),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _options.diseases.add(disease.name);
                      } else {
                        _options.diseases.remove(disease.name);
                      }
                    });
                  },
                );
              }).toList(),
        ),
        const Divider(),
      ],
    );
  }

  Widget _buildPriceFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Khoảng giá',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        RangeSlider(
          values: RangeValues(
            _options.minPrice,
            _options.maxPrice.clamp(
              0,
              10000000,
            ), // Đảm bảo giá trị không vượt quá max
          ),
          min: 0,
          max: 10000000, // Phải trùng với giá trị maxPrice trong FilterOptions
          divisions: 10,
          labels: RangeLabels(
            '${(_options.minPrice / 1000000).toStringAsFixed(1)}tr',
            '${(_options.maxPrice / 1000000).toStringAsFixed(1)}tr',
          ),
          onChanged: (values) {
            setState(() {
              _options.minPrice = values.start;
              _options.maxPrice = values.end;
            });
          },
        ),
        const Divider(),
      ],
    );
  }

  Widget _buildManufacturerFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Nơi sản xuất',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Wrap(
          spacing: 8,
          children:
              manufacturers.map((manu) {
                return CustomFilterChip(
                  label: manu.name,
                  isSelected: _options.manufacturers.contains(manu.name),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _options.manufacturers.add(manu.name);
                      } else {
                        _options.manufacturers.remove(manu.name);
                      }
                    });
                  },
                );
              }).toList(),
        ),
        const Divider(),
      ],
    );
  }

  Widget _buildDateFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ngày nhập',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        ListTile(
          title: Text(
            _options.importDateRange == null
                ? 'Chọn khoảng ngày'
                : '${_options.importDateRange!.start.day}/${_options.importDateRange!.start.month}/${_options.importDateRange!.start.year} - '
                    '${_options.importDateRange!.end.day}/${_options.importDateRange!.end.month}/${_options.importDateRange!.end.year}',
            style: const TextStyle(fontSize: 14),
          ),
          trailing: const Icon(Icons.calendar_today),
          onTap: () async {
            final DateTimeRange? picked = await showDateRangePicker(
              context: context,
              firstDate: DateTime(2020),
              lastDate: DateTime.now(),
            );
            if (picked != null) {
              setState(() {
                _options.importDateRange = picked;
              });
            }
          },
        ),
        const Divider(),
      ],
    );
  }

  Widget _buildPopularFilter() {
    return SwitchListTile(
      title: Text(
        'Chỉ hiển thị vắc xin được quan tâm',
        style: TextStyle(fontSize: 16),
      ),
      value: _options.onlyPopular,
      onChanged: (value) {
        setState(() {
          _options.onlyPopular = value;
        });
      },
    );
  }
}
