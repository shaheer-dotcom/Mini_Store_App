import 'package:flutter/material.dart';
import '../models/product.dart';

class CartProvider with ChangeNotifier {
  final Map<int, Product> _items = {};

  Map<int, Product> get items => _items;

  int get count => _items.length;

  double get totalPrice =>
      _items.values.fold(0, (sum, item) => sum + item.price);

  void addToCart(Product product) {
    _items[product.id] = product;
    notifyListeners();
  }

  void removeFromCart(int id) {
    _items.remove(id);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
