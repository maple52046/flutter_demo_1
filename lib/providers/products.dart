import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:minio/minio.dart';
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
    const url = 'http://tw2.maple52046.tk/parse/api/classes/Products';
    final mc = Minio(
      endPoint: '117.50.175.140',
      accessKey: 'O6Mp3e5C9UEuvoO6MqM3Hn59L1A2rO7T',
      secretKey: 'DC2bGRzcp3b8e0dVA86ukqpMtkT3fc7K',
      port: 32266,
      useSSL: false,
    );
    var options = Options(contentType: 'application/json', headers: const {
      'X-Parse-Application-Id': 'OzJ4sdzzOJF516jMIoW4LwLlu45wWBJl'
    });
    final dio = Dio();

    return mc
        .presignedGetObject('udemy', 'products.json', expires: 3600)
        .then((target) => dio.get<String>(target, options: options))
        .then((resp) async {
      final src = json.decode(resp.data as String) as Map<String, dynamic>;
      List<dynamic> objectIds = src['object_ids'];
      List<Future<Product>> futures = objectIds
          .map((objectId) => dio
              .get<Map<String, dynamic>>('$url/$objectId', options: options)
              .then((value) => Product(
                    id: value.data!['objectId'] as String,
                    title: value.data!['title'] as String,
                    description: value.data!['description'] as String,
                    price: value.data!['price'] as double,
                    imgUrl: value.data!['imgUrl'] as String,
                  )))
          .toList();
      _items = await Future.wait(futures);
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
    const url = 'http://tw2.maple52046.tk/parse/api/classes/Products';
    var options = Options(contentType: 'application/json', headers: const {
      'X-Parse-Application-Id': 'OzJ4sdzzOJF516jMIoW4LwLlu45wWBJl'
    });

    return Dio()
        .post<Map<String, dynamic>>(url,
            data: product.toJson(), options: options)
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
    }).catchError((err) {
      print('request failed: $err');
      throw err;
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
