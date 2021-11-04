import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:udemy_demo_1/providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> items;
  final DateTime date;

  OrderItem({
    required this.id,
    required this.amount,
    required this.items,
    required this.date,
  });

  String dateWithFmt(String fmt) {
    return DateFormat(fmt).format(date);
  }
}

class Orders extends ChangeNotifier {
  List<OrderItem> _orders = [];

  int get count {
    return _orders.length;
  }

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(Iterable<CartItem> items, double total) {
    final now = DateTime.now();
    _orders.insert(
      0,
      OrderItem(
        id: now.toString(),
        amount: total,
        items: items.toList(),
        date: now,
      ),
    );
    notifyListeners();
  }

  OrderItem getByIndex(int index) {
    return _orders[index];
  }
}
