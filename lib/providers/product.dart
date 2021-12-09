import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  String id;
  final String title;
  final String description;
  final double price;
  final String imgUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imgUrl,
    this.isFavorite = false,
  });

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
