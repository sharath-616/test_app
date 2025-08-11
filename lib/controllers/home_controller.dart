
import 'package:flutter/foundation.dart';
import 'package:test_app/Model/model.dart';


class HomeController with ChangeNotifier {
  List<Product> _products = [];
  List<String> _categories = ['All', 'Burger', 'Pizza', 'Drinks', 'Dessert'];
  String _selectedCategory = 'All';

  List<Product> get products => _products;
  List<String> get categories => _categories;
  String get selectedCategory => _selectedCategory;

  HomeController() {
    _loadProducts();
  }

  void _loadProducts() {
    _products = [
      Product(id: '1', name: 'Burger Special', image: '🍔', price: 12.99, category: 'Burger', rating: 4.5),
      Product(id: '2', name: 'Pizza Margherita', image: '🍕', price: 15.99, category: 'Pizza', rating: 4.8),
      Product(id: '3', name: 'French Fries', image: '🍟', price: 5.99, category: 'Burger', rating: 4.2),
      Product(id: '4', name: 'Coca Cola', image: '🥤', price: 2.99, category: 'Drinks', rating: 4.0),
      Product(id: '5', name: 'Ice Cream', image: '🍦', price: 4.99, category: 'Dessert', rating: 4.7),
      Product(id: '6', name: 'Chicken Wings', image: '🍗', price: 9.99, category: 'Burger', rating: 4.6),
    ];
    notifyListeners();
  }

  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  List<Product> get filteredProducts {
    if (_selectedCategory == 'All') return _products;
    return _products.where((p) => p?.category == _selectedCategory).toList();
  }
}
