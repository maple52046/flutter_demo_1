import 'dart:math';
import 'package:flutter/material.dart';
import 'package:udemy_demo_1/providers/cart.dart';
import 'package:udemy_demo_1/providers/orders.dart' as ord;
import 'package:udemy_demo_1/constant.dart' as constant;

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;

  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expand = false;

  Widget buildItem(CartItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            item.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            '${item.quantity}x \$${item.price}',
            style: const TextStyle(fontSize: 18, color: constant.grey),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.order.amount}'),
            subtitle: Text(widget.order.dateWithFmt('yyyy/MM/dd hh:mm')),
            trailing: IconButton(
              icon: Icon(_expand ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expand = !_expand;
                });
              },
            ),
          ),
          if (_expand)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: min(widget.order.items.length * 20 + 100, 100),
              child: ListView(
                children: widget.order.items.map((e) => buildItem(e)).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
