import 'package:flutter/material.dart';
import 'package:medihub_app/models/vaccine.dart';
import 'package:medihub_app/models/vaccine_package.dart';
import 'package:medihub_app/presentation/screens/services/vaccine_package.dart';

class PackageItem extends StatefulWidget {
  final List<VaccinePackage> vaccinePackages;
  final String img;
  final String title;
  final String price;
  final String discount;
  final String packageKey;
  final List<Vaccine> allVaccines;
  final Map<String, bool> expandedPackages; // Truyền trạng thái mở rộng
  final Function(String) onExpandToggle; // Callback để cập nhật trạng thái

  const PackageItem({
    super.key,
    required this.vaccinePackages,
    required this.img,
    required this.title,
    required this.price,
    required this.discount,
    required this.packageKey,
    required this.allVaccines,
    required this.expandedPackages,
    required this.onExpandToggle,
  });

  @override
  State<PackageItem> createState() => _PackageItemState();
}

class _PackageItemState extends State<PackageItem> {
  @override
  Widget build(BuildContext context) {
    final double newPrice =
        double.parse(widget.price) - double.parse(widget.discount);
    return Container(
      margin: const EdgeInsets.only(bottom: 7),
      height: widget.expandedPackages[widget.packageKey]! ? null : 87,
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
                widget.onExpandToggle(widget.packageKey);
              },
              child: SizedBox(
                height: 85,
                child: Row(
                  children: [
                    Image.asset(
                      widget.img,
                      width: 82,
                      height: 82,
                      fit: BoxFit.cover,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
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
                        widget.expandedPackages[widget.packageKey]!
                            ? Icons.expand_less
                            : Icons.expand_more,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (widget.expandedPackages[widget.packageKey]!)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: ListVaccine(
                packageKey: widget.packageKey,
                vaccinePackages:
                    widget.vaccinePackages, // Truyền dữ liệu cần thiết
                allVaccines: widget.allVaccines, // Truyền dữ liệu cần thiết
              ),
            ),
        ],
      ),
    );
  }
}

class ListVaccine extends StatelessWidget {
  final String packageKey;
  final List<VaccinePackage> vaccinePackages;
  final List<Vaccine> allVaccines;

  const ListVaccine({
    Key? key,
    required this.packageKey,
    required this.vaccinePackages,
    required this.allVaccines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final package = vaccinePackages.firstWhere(
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

    final vaccines = package.getVaccines(allVaccines);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(color: Colors.grey[300], height: 1),
          const SizedBox(height: 8),
          const Text(
            'Các loại vắc xin:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          ...vaccines.map(
            (vaccine) => Container(
              padding: const EdgeInsets.all(10),
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
                            (context) =>
                                VaccinePackageDetailScreen(package: package),
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
