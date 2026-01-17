import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => _items;

  void addToCart(Map<String, dynamic> product, int quantity) {
    _items.add({
      ...product,
      "quantity": quantity,
    });
    notifyListeners();
  }
}
