import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';

enum PriceSort { none, asc, desc }

class ProductProvider extends ChangeNotifier {
  final String _base = 'https://fakestoreapi.com';
  List<Product> _all = [];
  List<Product> get all => _all;

  String _search = '';
  String _category = 'All';
  PriceSort _sort = PriceSort.none;
  bool _loading = false;
  List<String> _categories = ['All'];

  String get search => _search;
  String get category => _category;
  PriceSort get sort => _sort;
  bool get loading => _loading;
  List<String> get categories => _categories;

  ProductProvider() {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    _loading = true;
    notifyListeners();
    try {
      final res = await http.get(Uri.parse('$_base/products'));
      if (res.statusCode == 200) {
        final List<dynamic> data = json.decode(res.body);
        _all = data.map((e) => Product.fromJson(e)).toList();
        await fetchCategories();
      }
    } catch (e) {
      if (kDebugMode) print('fetchProducts error: $e');
    }
    _loading = false;
    notifyListeners();
  }

  Future<void> fetchCategories() async {
    try {
      final res = await http.get(Uri.parse('$_base/products/categories'));
      if (res.statusCode == 200) {
        final List<dynamic> data = json.decode(res.body);
        _categories = ['All', ...data.map((e) => e.toString())];
      }
    } catch (e) {
      if (kDebugMode) print('fetchCategories error: $e');
    }
    notifyListeners();
  }

  void updateSearch(String s) {
    _search = s;
    notifyListeners();
  }

  void updateCategory(String c) {
    _category = c;
    notifyListeners();
  }

  void updateSort(PriceSort s) {
    _sort = s;
    notifyListeners();
  }

  List<Product> get filtered {
    List<Product> list = _all;
    if (_category != 'All') list = list.where((p) => p.category == _category).toList();
    if (_search.trim().isNotEmpty) {
      final q = _search.toLowerCase();
      list = list.where((p) => p.title.toLowerCase().contains(q)).toList();
    }
    if (_sort == PriceSort.asc) list.sort((a, b) => a.price.compareTo(b.price));
    if (_sort == PriceSort.desc) list.sort((a, b) => b.price.compareTo(a.price));
    return list;
  }
}
