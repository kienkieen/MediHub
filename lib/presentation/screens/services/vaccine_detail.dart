import 'package:flutter/material.dart';
import 'package:medihub_app/main.dart';
import 'package:medihub_app/presentation/screens/services/appointment.dart';
import 'package:provider/provider.dart';
import 'package:medihub_app/core/widgets/appbar.dart';
import 'package:medihub_app/models/vaccine.dart';
import 'package:medihub_app/providers/cart_provider.dart';
import 'package:medihub_app/core/widgets/button2.dart';

class VaccineDetailPage extends StatelessWidget {
  final Vaccine vaccine;

  const VaccineDetailPage({super.key, required this.vaccine});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppbarWidget(isBackButton: true, title: 'Chi tiết vắc xin'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              _buildVaccineInfoCard(context),
              const SizedBox(height: 10),
              _buildTabSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context, vaccine),
    );
  }

  Widget _buildVaccineInfoCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(),
          const SizedBox(height: 8),
          _buildTitleRow(context),
          const SizedBox(height: 4),
          _buildPrice(),
          const SizedBox(height: 8),
          Text(
            vaccine.description,
            style: TextStyle(color: Colors.grey[800], fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Image.asset(vaccine.imageUrl, fit: BoxFit.cover),
    );
  }

  Widget _buildTitleRow(BuildContext context) {
    return Row(
      children: [
        Text(
          vaccine.name,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 8),
        if (vaccine.isPopular ?? false)
          const Icon(Icons.star, color: Colors.orange),
      ],
    );
  }

  Widget _buildPrice() {
    return Text(
      '${vaccine.price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}đ',
      style: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }

  Widget _buildTabSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _boxDecoration(),
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
              labelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Sansita',
                color: Colors.black,
              ),
              tabs: [Tab(text: 'Thông tin'), Tab(text: 'Phác đồ lịch tiêm')],
            ),
            SizedBox(
              height: 300,
              child: TabBarView(
                children: [_buildInfoTab(), _buildScheduleTab()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, Vaccine vaccine) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BuildButton3(
            text: 'Thêm vào giỏ',
            textSize: 14,
            width: 160,
            height: 42,
            onPressed: () {
              Provider.of<CartProvider>(
                context,
                listen: false,
              ).addItem(vaccine.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${vaccine.name} đã được thêm vào giỏ hàng'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
          BuildButton4(
            text: 'Đặt lịch tiêm',
            textSize: 14,
            width: 160,
            height: 42,
            onPressed: () {
              selectedVaccinesBooKing.add(vaccine);
              sumBill += vaccine.price;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VaccinationBookingScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required Color color,
    required String text,
    required Color textColor,
    Color? borderColor,
    required VoidCallback onTap,
  }) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border:
                borderColor != null
                    ? Border.all(color: borderColor, width: 1.3)
                    : null,
          ),
          child: Text(text, style: TextStyle(color: textColor)),
        ),
      ),
    );
  }

  Widget _buildInfoTab() {
    return ListView(
      padding: const EdgeInsets.only(top: 16),
      children: [
        _buildDetailItem('Nước sản xuất:', vaccine.manufacturer),
        _buildDetailItem('Phòng bệnh:', vaccine.diseases.join(', ')),
        _buildDetailItem('Độ tuổi:', vaccine.ageRange),
        _buildDetailItem('Đường tiêm:', vaccine.administrationRoute),
        _buildDetailItem('Bảo quản:', vaccine.storageCondition),
        if (vaccine.contraindications.isNotEmpty)
          _buildDetailItemWithBullets(
            'Chống chỉ định:',
            vaccine.contraindications,
          ),
        if (vaccine.precautions.isNotEmpty)
          _buildDetailItemWithBullets(
            'Điều cần thận trọng:',
            vaccine.precautions,
          ),
        if (vaccine.sideEffects.isNotEmpty)
          _buildDetailItemWithBullets('Tác dụng phụ:', vaccine.sideEffects),
      ],
    );
  }

  Widget _buildScheduleTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children:
          vaccine.vaccinationSchedules.map((schedule) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lịch tiêm cho ${schedule.ageGroup}:',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                ...schedule.doses.map(
                  (dose) => Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [const Text('– '), Expanded(child: Text(dose))],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            );
          }).toList(),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 15))),
        ],
      ),
    );
  }

  Widget _buildDetailItemWithBullets(String label, List<String> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  items
                      .map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('– '),
                              Expanded(
                                child: Text(
                                  item,
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
      color: Colors.white,
    );
  }
}
