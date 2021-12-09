import 'package:flutter/material.dart';
import 'package:udemy_demo_1/providers/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imgUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imgUrl: 'http://tw2.maple52046.tk/dev/trousers.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imgUrl: 'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imgUrl: 'http://tw2.maple52046.tk/dev/pan.jpg',
    ),
  ];

  bool _showFavoriteOnly = false;

  List<Product> get items {
    if (_showFavoriteOnly) {
      return [..._items.where((p) => p.isFavorite)];
    }

    return [..._items];
  }

  Product getById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  void addProduct(Product product) {
    var productId = 'p${_items.length + 1}';
    product.id = productId;
    _items.add(product);
    notifyListeners();
  }

  void removeProductById(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void removeProduct(Product product) {
    if (_items.contains(product)) {
      _items.remove(product);
      print('remove product: ${product.title}');
    }
  }

  void showAll() {
    _showFavoriteOnly = false;
    notifyListeners();
  }

  void showFavoriteOnly() {
    _showFavoriteOnly = true;
    notifyListeners();
  }
}
