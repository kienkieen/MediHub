import 'package:medihub_app/models/vaccine.dart';

class VaccinePackage {
  final String id; // ID gói
  final String name; // Tên gói
  final String ageGroup; // Nhóm tuổi (VD: "6 tuần - dưới 7 tháng")
  final String description; // Mô tả
  final List<String> vaccineIds; // Danh sách ID vắc xin
  final Map<String, int> dosesByVaccine; // Số liều tiêm cho từng vaccine
  final double totalPrice; // Tổng giá tiền
  final double discount; // Giảm giá
  final String imageUrl; // Ảnh đại diện gói
  bool isActive; // Trạng thái hoạt động của gói

  VaccinePackage({
    required this.id,
    required this.name,
    required this.ageGroup,
    required this.description,
    required this.vaccineIds,
    required this.dosesByVaccine,
    required this.totalPrice,
    required this.discount,
    required this.imageUrl,
    this.isActive = false,
  });

  // Lấy danh sách vaccine từ danh sách ID
  List<Vaccine> getVaccines(List<Vaccine> allVaccines) {
    return allVaccines
        .where((vaccine) => vaccineIds.contains(vaccine.id))
        .toList();
  }

  // Lấy số liều tiêm của một vaccine trong gói
  int getDosesForVaccine(String vaccineId) {
    return dosesByVaccine[vaccineId] ??
        1; // Mặc định là 1 liều nếu không có thông tin
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'ageGroup': ageGroup,
      'description': description,
      'vaccineIds': vaccineIds,
      'dosesByVaccine': dosesByVaccine,
      'totalPrice': totalPrice,
      'discount': discount,
      'imageUrl': imageUrl,
      'isActive': isActive,
    };
  }

  factory VaccinePackage.fromMap(Map<String, dynamic> map) {
    return VaccinePackage(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      ageGroup: map['ageGroup'] ?? '',
      description: map['description'] ?? '',
      vaccineIds: List<String>.from(map['vaccineIds'] ?? []),
      dosesByVaccine: Map<String, int>.from(map['dosesByVaccine'] ?? {}),
      totalPrice: (map['totalPrice'] ?? 0).toDouble(),
      discount: (map['discount'] ?? 0).toDouble(),
      imageUrl: map['imageUrl'] ?? '',
      isActive: map['isActive'] ?? false,
    );
  }
}
