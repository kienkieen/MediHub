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
  });

  // Lấy danh sách vaccine từ danh sách ID
  List<Vaccine> getVaccines(List<Vaccine> allVaccines) {
    return allVaccines.where((vaccine) => vaccineIds.contains(vaccine.id)).toList();
  }

  // Lấy số liều tiêm của một vaccine trong gói
  int getDosesForVaccine(String vaccineId) {
    return dosesByVaccine[vaccineId] ?? 1; // Mặc định là 1 liều nếu không có thông tin
  }
}