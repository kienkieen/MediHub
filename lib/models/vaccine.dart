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
