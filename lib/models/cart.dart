import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:medihub_app/main.dart';
import 'package:medihub_app/models/vaccine.dart';
import 'package:medihub_app/models/vaccine_package.dart';

class CartVaccineItem {
  final String vaccineId;
  final DateTime addedAt;

  CartVaccineItem({required this.vaccineId, DateTime? addedAt})
    : addedAt = addedAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {'vaccine': vaccineId, 'addedAt': addedAt};
  }

  factory CartVaccineItem.fromMap(Map<String, dynamic> map) {
    return CartVaccineItem(
      vaccineId: map['vaccine'] as String,
      addedAt: (map['addedAt'] as Timestamp).toDate(),
    );
  }
}

class CartVaccinePackage {
  final String packageId;
  final DateTime addedAt;
  CartVaccinePackage({required this.packageId, DateTime? addedAt})
    : addedAt = addedAt ?? DateTime.now();
  Map<String, dynamic> toMap() {
    return {
      'package': packageId, // Giả sử VaccinePackage đã có toMap()
      'addedAt': addedAt,
    };
  }

  factory CartVaccinePackage.fromMap(Map<String, dynamic> map) {
    return CartVaccinePackage(
      packageId: map['package'] as String,
      addedAt: (map['addedAt'] as Timestamp).toDate(),
    );
  }
}

class Cart {
  List<CartVaccineItem> vaccineItems = [];
  List<CartVaccinePackage> vaccinePackages = [];
  String? userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Cart({this.userId}) {
    final now = DateTime.now();
    createdAt = now;
    updatedAt = now;
  }

  void setVaccineItems(List<CartVaccineItem> items) {
    vaccineItems = items;
  }

  void setVaccinePackages(List<CartVaccinePackage> packages) {
    vaccinePackages = packages;
  }

  // Thêm vắc xin vào giỏ
  void addVaccineItem(String vaccineId) {
    if (!vaccineItems.any((item) => item.vaccineId == vaccineId)) {
      vaccineItems.add(CartVaccineItem(vaccineId: vaccineId));
      updatedAt = DateTime.now();
    }
  }

  // Thêm gói vắc xin vào giỏ
  void addVaccinePackage(String packageId) {
    if (!vaccinePackages.any((item) => item.packageId == packageId)) {
      vaccinePackages.add(CartVaccinePackage(packageId: packageId));
      updatedAt = DateTime.now();
    }
  }

  // Xóa vắc xin khỏi giỏ
  void removeVaccineItem(String vaccineId) {
    vaccineItems.removeWhere((item) => item.vaccineId == vaccineId);
    updatedAt = DateTime.now();
  }

  // Xóa gói vắc xin khỏi giỏ
  void removeVaccinePackage(String packageId) {
    vaccinePackages.removeWhere((item) => item.packageId == packageId);
    updatedAt = DateTime.now();
  }

  // Xóa toàn bộ giỏ
  void clear() {
    vaccineItems.clear();
    updatedAt = DateTime.now();
  }

  // Lấy số lượng vắc xin (số loại khác nhau)
  int get itemCount => vaccineItems.length;

  // Lấy số lượng gói vắc xin (số loại khác nhau)
  int get packageCount => vaccinePackages.length;

  // Tính tổng tiền
  double get totalPrice {
    double total = 0.0;

    for (Vaccine i in allVaccines) {
      if (vaccineItems.any((item) => item.vaccineId == i.id)) {
        total += i.price;
      }
    }
    return total;
  }

  // Tính tổng tiền cho các gói vắc xin
  double get totalPackagePrice {
    double total = 0.0;

    for (VaccinePackage i in allVaccinePackages) {
      if (vaccinePackages.any((item) => item.packageId == i.id)) {
        total += i.totalPrice;
      }
    }
    return total;
  }

  double get totalCartPrice => totalPrice + totalPackagePrice;

  // Lấy danh sách gói vắc xin (read-only)
  List<CartVaccinePackage> get getVaccinepackages =>
      List.unmodifiable(vaccinePackages);

  // Lấy danh sách items (read-only)
  List<CartVaccineItem> get getVaccineitems => List.unmodifiable(vaccineItems);
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'vaccineItems': vaccineItems.map((item) => item.toMap()).toList(),
      'vaccinePackages': vaccinePackages.map((item) => item.toMap()).toList(),
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(userId: map['userId'] as String?)
      ..createdAt =
          map['createdAt'] != null
              ? (map['createdAt'] as Timestamp).toDate()
              : null
      ..updatedAt =
          map['updatedAt'] != null
              ? (map['updatedAt'] as Timestamp).toDate()
              : null
      ..vaccineItems =
          (map['vaccineItems'] as List<dynamic>?)
              ?.map(
                (item) => CartVaccineItem.fromMap(item as Map<String, dynamic>),
              )
              .toList() ??
          []
      ..vaccinePackages =
          (map['vaccinePackages'] as List<dynamic>?)
              ?.map(
                (item) =>
                    CartVaccinePackage.fromMap(item as Map<String, dynamic>),
              )
              .toList() ??
          [];
  }
}
