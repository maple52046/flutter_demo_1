import 'package:flutter/foundation.dart';
import 'package:udemy_demo_1/providers/product.dart';

class CartItem {
  String id;
  String productId;
  String title;
  double price;
  int quantity = 1;

  CartItem(this.id, this.productId, this.title, this.price);

  double get amount {
    return price * quantity;
  }

  void addOne() {
    quantity += 1;
  }
}

class Cart extends ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get count {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, item) {
      total += item.price * item.quantity;
    });
    return total;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items[product.id]!.addOne();
      notifyListeners();
      return;
    }

    final itemId = DateTime.now().toString();
    _items.putIfAbsent(
      product.id,
      () => CartItem(itemId, product.id, product.title, product.price),
    );
    notifyListeners();
  }

  void removeAll() {
    _items = {};
    notifyListeners();
  }

  void removeItem(String productId) {
    print('deleting $productId');
    if (_items.containsKey(productId)) {
      _items.remove(productId);
      notifyListeners();
    }
  }

  bool productInCart(String productId) {
    return _items.containsKey(productId);
  }
}
