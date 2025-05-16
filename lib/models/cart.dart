import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medihub_app/models/vaccine.dart';
class CartItem {
  final Vaccine vaccine;
  final DateTime addedAt;

  CartItem({
    required this.vaccine,
    DateTime? addedAt,
  }) : addedAt = addedAt ?? DateTime.now();
}

class Cart {
  final List<CartItem> _items = [];
  String? userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Cart({this.userId}) {
    final now = DateTime.now();
    createdAt = now;
    updatedAt = now;
  }

  // Thêm vắc xin vào giỏ
  void addItem(Vaccine vaccine) {
    if (!_items.any((item) => item.vaccine.id == vaccine.id)) {
      _items.add(CartItem(vaccine: vaccine));
      updatedAt = DateTime.now();
    }
  }

  // Xóa vắc xin khỏi giỏ
  void removeItem(String vaccineId) {
    _items.removeWhere((item) => item.vaccine.id == vaccineId);
    updatedAt = DateTime.now();
  }

  // Xóa toàn bộ giỏ
  void clear() {
    _items.clear();
    updatedAt = DateTime.now();
  }

  // Lấy số lượng vắc xin (số loại khác nhau)
  int get itemCount => _items.length;

  // Tính tổng tiền
  double get totalPrice => _items.fold(0, (sum, item) => sum + item.vaccine.price);

  // Lấy danh sách items (read-only)
  List<CartItem> get items => List.unmodifiable(_items);
}