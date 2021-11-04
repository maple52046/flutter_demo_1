import 'dart:math';
import 'package:flutter/material.dart';
import 'package:udemy_demo_1/providers/cart.dart';
import 'package:udemy_demo_1/providers/orders.dart' as ord;

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
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${item.quantity}x \$${item.price}',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
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
          // Container(
          //   height: expand ? widget.order.items.length * 50 : 0,
          //   child: ListView.builder(
          //     itemCount: expand ? widget.order.items.length : 0,
          //     itemBuilder: (ctx, i) => ListTile(
          //       title: Text(widget.order.items[i].title),
          //     ),
          //   ),
          // ),
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
