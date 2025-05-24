import 'package:flutter/material.dart';

class Vaccine {
  final String id; // ID vắc xin
  final String name; // Tên vắc xin
  final String description; // Mô tả
  final List<String> diseases; // Bệnh
  final String ageRange; // Độ tuổi tiêm
  final double price; // Giá
  final DateTime importedDate; // Ngày nhập
  final String manufacturer; // Nhà sản xuất
  final bool isPopular; // Phổ biến
  final String imageUrl; // Ảnh
  final List<VaccinationSchedule> vaccinationSchedules; // Lịch tiêm
  final String administrationRoute; // Đường tiêm
  final List<String> contraindications; // Chống chỉ định
  final String storageCondition; // Bảo quản
  final List<String> precautions; // Điều cần thận trọng
  final List<String> sideEffects; // Tác dụng phụ

  Vaccine({
    required this.id,
    required this.name,
    required this.description,
    required this.diseases,
    required this.ageRange,
    required this.price,
    required this.importedDate,
    required this.manufacturer,
    this.isPopular = false,
    required this.imageUrl,
    required this.vaccinationSchedules,
    required this.administrationRoute,
    required this.contraindications,
    required this.storageCondition,
    this.precautions = const [],
    this.sideEffects = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'diseases': diseases,
      'ageRange': ageRange,
      'price': price,
      'importedDate': importedDate.toIso8601String(),
      'manufacturer': manufacturer,
      'isPopular': isPopular,
      'imageUrl': imageUrl,
      'vaccinationSchedules':
          vaccinationSchedules.map((e) => e.toMap()).toList(),
      'administrationRoute': administrationRoute,
      'contraindications': contraindications,
      'storageCondition': storageCondition,
      'precautions': precautions,
      'sideEffects': sideEffects,
    };
  }

  factory Vaccine.fromMap(Map<String, dynamic> map) {
    return Vaccine(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      diseases: List<String>.from(map['diseases'] ?? []),
      ageRange: map['ageRange'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      importedDate: DateTime.parse(map['importedDate']),
      manufacturer: map['manufacturer'] ?? '',
      isPopular: map['isPopular'] ?? false,
      imageUrl: map['imageUrl'] ?? '',
      vaccinationSchedules:
          (map['vaccinationSchedules'] as List<dynamic>? ?? [])
              .map((e) => VaccinationSchedule.fromMap(e))
              .toList(),
      administrationRoute: map['administrationRoute'] ?? '',
      contraindications: List<String>.from(map['contraindications'] ?? []),
      storageCondition: map['storageCondition'] ?? '',
      precautions: List<String>.from(map['precautions'] ?? []),
      sideEffects: List<String>.from(map['sideEffects'] ?? []),
    );
  }
}

class FilterOptions {
  String? category;
  String? ageRange;
  List<String> diseases = [];
  double minPrice = 0;
  double maxPrice = 10000000;
  List<String> manufacturers = [];
  DateTimeRange? importDateRange;
  bool onlyPopular = false;

  FilterOptions();
}

class VaccinationSchedule {
  final String ageGroup; // Nhóm tuổi (VD: "6 tuần - dưới 7 tháng")
  final List<String> doses; // Danh sách các mũi tiêm

  VaccinationSchedule({required this.ageGroup, required this.doses});
  Map<String, dynamic> toMap() {
    return {'ageGroup': ageGroup, 'doses': doses};
  }

  factory VaccinationSchedule.fromMap(Map<String, dynamic> map) {
    return VaccinationSchedule(
      ageGroup: map['ageGroup'] ?? '',
      doses: List<String>.from(map['doses'] ?? []),
    );
  }
}

List<Vaccine> vaccines = [
  Vaccine(
    id: 'v001',
    name: 'Vắc xin 6 trong 1 Hexaxim',
    description:
        'Vắc xin Prevenar 13 (Bỉ) phòng các bệnh phế cầu khuẩn xâm lấn...',
    diseases: ['Bạch hầu', 'Uốn ván', 'Ho gà', 'Bại liệt', 'Hib', 'Viêm gan B'],
    ageRange: '0-1 tuổi',
    price: 1850000,
    importedDate: DateTime(2023, 10, 15),
    manufacturer: 'Sanofi (Pháp)',
    isPopular: true,
    imageUrl: 'assets/images/vaccine/vc1.jpg',
    vaccinationSchedules: [
      VaccinationSchedule(
        ageGroup: 'Trẻ 6 tuần tuổi đến dưới 7 tháng',
        doses: [
          'Mũi 1: Lần tiêm đầu tiên',
          'Mũi 2: 1 tháng sau mũi 1',
          'Mũi 3: 1 tháng sau mũi 2',
          'Mũi 4: 6 tháng sau mũi 3',
        ],
      ),
      VaccinationSchedule(
        ageGroup: 'Trẻ 7 tháng tuổi đến dưới 1 tuổi',
        doses: [
          'Mũi 1: Lần tiêm đầu tiên',
          'Mũi 2: 1 tháng sau mũi 1',
          'Mũi 3: 6 tháng sau mũi 2',
        ],
      ),
      VaccinationSchedule(
        ageGroup: 'Trẻ 1 tuổi đến dưới 6 tuổi',
        doses: ['Mũi 1: Lần tiêm đầu tiên', 'Mũi 2: 2 tháng sau mũi 1'],
      ),
    ],
    administrationRoute: 'Tiêm bắp',
    contraindications: [
      'Phụ nữ có thai',
      'Người có tiền sử dị ứng nặng',
      'Bệnh nhân mắc bệnh thể ẩn và trong giai đoạn dưỡng bệnh',
      'Người có bệnh lý nền nặng',
      'Người đang điều trị bằng thuốc ức chế miễn dịch',
      'Người đang điều trị bằng thuốc kháng virus',
      'Người có triệu chứng co giật trong vòng 1 năm trước khi tiêm chủng',
    ],
    storageCondition: '2-8°C, không đông băng',
    precautions: ['Hoãn tiêm nếu trẻ sốt ≥ 38°C', 'Theo dõi 30 phút sau tiêm'],
    sideEffects: ['Sưng đau tại chỗ tiêm', 'Quấy khóc', 'Sốt nhẹ < 39°C'],
  ),
  Vaccine(
    id: 'v002',
    name: 'Vắc xin Gardasil (HPV)',
    description:
        'Vắc xin Prevenar 13 (Bỉ) phòng các bệnh phế cầu khuẩn xâm lấn...',
    diseases: ['HPV type 6,11,16,18', 'Ung thư cổ tử cung', 'Sùi mào gà'],
    ageRange: '1-5 tuổi',
    price: 3200000,
    importedDate: DateTime(2023, 9, 20),
    manufacturer: 'Merck (Mỹ)',
    isPopular: true,
    imageUrl: 'assets/images/vaccine/vc2.jpg',
    vaccinationSchedules: [
      VaccinationSchedule(
        ageGroup: 'Trẻ 6 tuần tuổi đến dưới 7 tháng',
        doses: [
          'Mũi 1: Lần tiêm đầu tiên',
          'Mũi 2: 1 tháng sau mũi 1',
          'Mũi 3: 1 tháng sau mũi 2',
          'Mũi 4: 6 tháng sau mũi 3',
        ],
      ),
      VaccinationSchedule(
        ageGroup: 'Trẻ 7 tháng tuổi đến dưới 1 tuổi',
        doses: [
          'Mũi 1: Lần tiêm đầu tiên',
          'Mũi 2: 1 tháng sau mũi 1',
          'Mũi 3: 6 tháng sau mũi 2',
        ],
      ),
      VaccinationSchedule(
        ageGroup: 'Trẻ 1 tuổi đến dưới 6 tuổi',
        doses: ['Mũi 1: Lần tiêm đầu tiên', 'Mũi 2: 2 tháng sau mũi 1'],
      ),
    ],
    administrationRoute: 'Tiêm bắp tay',
    contraindications: [
      'Phụ nữ có thai',
      'Người có tiền sử dị ứng nặng',
      'Bệnh nhân mắc bệnh thể ẩn và trong giai đoạn dưỡng bệnh',
      'Người có bệnh lý nền nặng',
      'Người đang điều trị bằng thuốc ức chế miễn dịch',
      'Người đang điều trị bằng thuốc kháng virus',
      'Người có triệu chứng co giật trong vòng 1 năm trước khi tiêm chủng',
    ],
    storageCondition: '2-8°C, tránh ánh sáng',
    precautions: [
      'Không tiêm cho phụ nữ mang thai',
      'Có thể chảy máu nhẹ khi tiêm',
    ],
    sideEffects: ['Đau đầu', 'Chóng mặt', 'Ngứa tại chỗ tiêm'],
  ),
  Vaccine(
    id: 'v003',
    name: 'Vắc xin COVID-19 Pfizer',
    description:
        'Vắc xin Prevenar 13 (Bỉ) phòng các bệnh phế cầu khuẩn xâm lấn...',
    diseases: ['COVID-19'],
    ageRange: 'Trên 18 tuổi',
    price: 850000,
    importedDate: DateTime(2023, 11, 5),
    manufacturer: 'Pfizer-BioNTech (Mỹ-Đức)',
    imageUrl: 'assets/images/vaccine/vc1.jpg',
    vaccinationSchedules: [
      VaccinationSchedule(
        ageGroup: 'Trẻ 6 tuần tuổi đến dưới 7 tháng',
        doses: [
          'Mũi 1: Lần tiêm đầu tiên',
          'Mũi 2: 1 tháng sau mũi 1',
          'Mũi 3: 1 tháng sau mũi 2',
          'Mũi 4: 6 tháng sau mũi 3',
        ],
      ),
      VaccinationSchedule(
        ageGroup: 'Trẻ 7 tháng tuổi đến dưới 1 tuổi',
        doses: [
          'Mũi 1: Lần tiêm đầu tiên',
          'Mũi 2: 1 tháng sau mũi 1',
          'Mũi 3: 6 tháng sau mũi 2',
        ],
      ),
      VaccinationSchedule(
        ageGroup: 'Trẻ 1 tuổi đến dưới 6 tuổi',
        doses: ['Mũi 1: Lần tiêm đầu tiên', 'Mũi 2: 2 tháng sau mũi 1'],
      ),
    ],
    administrationRoute: 'Tiêm bắp',
    contraindications: [
      'Phụ nữ có thai',
      'Người có tiền sử dị ứng nặng',
      'Bệnh nhân mắc bệnh thể ẩn và trong giai đoạn dưỡng bệnh',
      'Người có bệnh lý nền nặng',
      'Người đang điều trị bằng thuốc ức chế miễn dịch',
      'Người đang điều trị bằng thuốc kháng virus',
      'Người có triệu chứng co giật trong vòng 1 năm trước khi tiêm chủng',
    ],
    storageCondition: '-90°C đến -60°C (trước khi pha)',
    sideEffects: ['Mệt mỏi', 'Đau cơ', 'Sốt nhẹ 1-2 ngày'],
  ),
];
