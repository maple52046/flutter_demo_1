import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:udemy_demo_1/drivers/parse.dart';

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

  Future update() {
    print('updating product: $id');
    final dio = getParseClient();
    return dio.put<Map<String, dynamic>>('/$id', data: toJson());
  }

  String toJson() {
    return json.encode({
      'title': title,
      'description': description,
      'price': price,
      'imgUrl': imgUrl,
    });
  }
}
