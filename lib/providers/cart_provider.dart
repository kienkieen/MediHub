import 'package:flutter/material.dart';
import 'package:medihub_app/models/cart.dart';
import 'package:medihub_app/models/vaccine.dart';

class CartProvider with ChangeNotifier {
  final Cart _cart = Cart();

  Cart get cart => _cart;

  void addItem(Vaccine vaccine) {
    _cart.addItem(vaccine);
    notifyListeners(); // Thông báo cho các widget lắng nghe
  }

  void removeItem(String vaccineId) {
    _cart.removeItem(vaccineId);
    notifyListeners();
  }

  void clear() {
    _cart.clear();
    notifyListeners();
  }
}