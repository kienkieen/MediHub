import 'package:flutter/material.dart';
import 'package:medihub_app/core/widgets/appbar.dart';
import 'package:medihub_app/core/widgets/login_widgets/button.dart';

class MedicalExaminationFormScreen extends StatefulWidget {
  const MedicalExaminationFormScreen({super.key});

  @override
  State<MedicalExaminationFormScreen> createState() =>
      _MedicalExaminationFormScreenState();
}

class _MedicalExaminationFormScreenState
    extends State<MedicalExaminationFormScreen> {
  int _selectedFilter = 1; // 1 = Đã thanh toán (mặc định)

  // Danh sách filter để dễ dàng thay đổi
  final List<Map<String, dynamic>> _filters = [
    {'id': 1, 'title': 'Đã thanh toán'},
    {'id': 2, 'title': 'Chưa thanh toán'},
    {'id': 3, 'title': 'Đã khám'},
    {'id': 4, 'title': 'Đã huỷ'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(title: 'Danh sách phiếu khám'),
      body: Column(
        children: [
          _buildFilterBar(),
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      height: 70, // Fixed height for filter bar
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        itemCount: _filters.length,
        separatorBuilder: (context, index) => const SizedBox(width: 15),
        itemBuilder: (context, index) {
          final filter = _filters[index];
          return FilterButton(
            title: filter['title'],
            isSelected: _selectedFilter == filter['id'],
            onPressed: () => setState(() => _selectedFilter = filter['id']),
          );
        },
      ),
    );
  }

  Widget _buildContent() {
    switch (_selectedFilter) {
      case 1:
        return _buildStatusContent('Danh sách phiếu đã thanh toán');
      case 2:
        return _buildStatusContent('Danh sách phiếu chưa thanh toán');
      case 3:
        return _buildStatusContent('Danh sách phiếu đã khám');
      case 4:
        return _buildStatusContent('Danh sách phiếu đã huỷ');
      default:
        return _buildStatusContent('Danh sách phiếu đã thanh toán');
    }
  }

  Widget _buildStatusContent(String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 20),
        Image.asset("assets/icons/icon_9.png", width: 260, height: 260),
      ],
    );
  }
}