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
  final String storageCondition;  // Bảo quản
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
  
  VaccinationSchedule({
    required this.ageGroup,
    required this.doses,
  });
}