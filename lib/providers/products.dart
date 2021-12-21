import 'package:flutter/material.dart';
import 'package:udemy_demo_1/drivers/minio.dart';
import 'package:udemy_demo_1/drivers/parse.dart';
import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imgUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imgUrl: 'http://tw2.maple52046.tk/dev/trousers.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imgUrl: 'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imgUrl: 'http://tw2.maple52046.tk/dev/pan.jpg',
    // ),
  ];

  bool _showFavoriteOnly = false;

  Future fetchItems() {
    final mc = getMinioClient();
    final dio = getParseClient();

    return mc
        .presignedGetObject('udemy', 'products.json', expires: 3600)
        .then((target) => dio.get<Map<String, dynamic>>(target))
        .then((resp) async {
      List<dynamic> objectIds = resp.data!['object_ids'];
      List<Future<Product>> futures = objectIds
          .map((objectId) => dio
              .get<Map<String, dynamic>>('/$objectId')
              .then((value) => Product(
                    id: value.data!['objectId'] as String,
                    title: value.data!['title'] as String,
                    description: value.data!['description'] as String,
                    price: value.data!['price'] as double,
                    imgUrl: value.data!['imgUrl'] as String,
                  )))
          .toList();
      _items = await Future.wait(futures);
      notifyListeners();
    });
  }

  List<Product> get items {
    if (_showFavoriteOnly) {
      return [..._items.where((p) => p.isFavorite)];
    }

    return [..._items];
  }

  Product getById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  Future addProduct(Product product) {
    final dio = getParseClient();
    return dio
        .post<Map<String, dynamic>>('', data: product.toJson())
        .then((resp) {
      if (resp.statusCode != 201) {
        print('add product failed (status: ${resp.statusCode}');
        print(resp.data);
        return;
      }
      product.id = resp.data!['objectId'] as String;
      _items.add(product);
      notifyListeners();
      print('add product successfully (object id: ${product.id})');
    });
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
