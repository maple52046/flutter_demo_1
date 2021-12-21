import 'package:udemy_demo_1/providers/product.dart';

class ProductNotFound implements Exception {
  final Product product;
  ProductNotFound(this.product);

  @override
  String toString() {
    return '${product.id} not founded';
  }
}
