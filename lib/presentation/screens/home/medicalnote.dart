import 'package:flutter/material.dart';
import 'package:medihub_app/core/widgets/appbar.dart';

class MedicalExaminationFormScreen extends StatefulWidget {
  const MedicalExaminationFormScreen({super.key});

  @override
  State<MedicalExaminationFormScreen> createState() =>
      _MedicalExaminationFormScreenState();
}

class _MedicalExaminationFormScreenState
    extends State<MedicalExaminationFormScreen> {
  int _selectedFilter = 1; // 1 = Đã thanh toán (mặc định)

  // Các nội dung tương ứng với từng filter
  final Map<int, Widget> _filterContents = {
    1: _buildPaidContent(),
    2: _buildUnpaidContent(),
    3: _buildExaminedContent(),
    4: _buildCancelledContent(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(title: 'Danh sách phiếu khám'),
      body: Column(
        children: [
          Expanded(flex: 1, child: _buildFilters()),
          Expanded(
            flex: 9,
            child: Center(
              child: _filterContents[_selectedFilter] ?? _buildPaidContent(),
            ),
          ),
        ],
      ),
    );
  }

  // Các hàm build content
  static Widget _buildPaidContent() {
    return Column(
      children: [
        SizedBox(height: 20),
        Text('Danh sách phiếu đã thanh toán'),
        SizedBox(height: 20),
        Image.asset("assets/icons/icon_9.png", width: 260, height: 260),
      ],
    );
  }

  static Widget _buildUnpaidContent() {
    return Column(
      children: [
        SizedBox(height: 20),
        Text('Danh sách phiếu chưa thanh toán'),
        SizedBox(height: 20),
        Image.asset("assets/icons/icon_9.png", width: 260, height: 260),
      ],
    );
  }

  static Widget _buildExaminedContent() {
    return Column(
      children: [
        SizedBox(height: 20),
        Text('Danh sách phiếu đã khám'),
        SizedBox(height: 20),
        Image.asset("assets/icons/icon_9.png", width: 260, height: 260),
      ],
    );
  }

  static Widget _buildCancelledContent() {
    return Column(
      children: [
        SizedBox(height: 20),
        Text('Danh sách phiếu chưa đã huỷ'),
        SizedBox(height: 20),
        Image.asset("assets/icons/icon_9.png", width: 260, height: 260),
      ],
    );
  }

  Widget _buildFiltersButton(int key, String title) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        gradient:
            _selectedFilter == key
                ? LinearGradient(
                  colors: [Color(0xFF019BD3), Color(0xA701CBEE)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
                : null,
        color: _selectedFilter != key ? Colors.grey.shade200 : null,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _selectedFilter = key; // Cập nhật state khi nhấn
          });
        },
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.all(12),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: _selectedFilter == key ? Colors.white : Colors.grey.shade800,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(width: 15),
            _buildFiltersButton(1, 'Đã thanh toán'),
            SizedBox(width: 15),
            _buildFiltersButton(2, 'Chưa thanh toán'),
            SizedBox(width: 15),
            _buildFiltersButton(3, 'Đã khám'),
            SizedBox(width: 15),
            _buildFiltersButton(4, 'Đã huỷ'),
            SizedBox(width: 15),
          ],
        ),
      ),
    );
  }
}
