import 'package:flutter/material.dart';
import 'package:medihub_app/firebase_helper/cart_helper.dart';
import 'package:medihub_app/main.dart';
import 'package:medihub_app/models/cart.dart';
import 'package:medihub_app/models/vaccine.dart';
import 'package:medihub_app/models/vaccine_package.dart';

class CartProvider with ChangeNotifier {
  final Cart _cart = cart;

  Cart get getCart => _cart;

  void addItem(Vaccine vaccine) {
    _cart.addVaccineItem(vaccine);
    cart = _cart; // Cập nhật cart toàn cục
    saveCart(cart);
    notifyListeners(); // Thông báo cho các widget lắng nghe
  }

  void removeItem(String vaccineId) {
    _cart.removeVaccineItem(vaccineId);
    cart = _cart; // Cập nhật cart toàn cục
    saveCart(cart);
    notifyListeners();
  }

  void addPackage(VaccinePackage package) {
    _cart.addVaccinePackage(package);
    cart = _cart; // Cập nhật cart toàn cục
    saveCart(cart);
    notifyListeners();
  }

  void removePackage(String packageId) {
    _cart.removeVaccinePackage(packageId);
    cart = _cart; // Cập nhật cart toàn cục
    saveCart(cart);
    notifyListeners();
  }

  void clear() {
    _cart.clear();
    cart = _cart; // Cập nhật cart toàn cục
    saveCart(cart);
    notifyListeners();
  }
}
