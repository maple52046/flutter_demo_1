import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_demo_1/providers/orders.dart';
import 'package:udemy_demo_1/widgets/app_drawer.dart';
import 'package:udemy_demo_1/widgets/order_item_card.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Orders')),
      body: Consumer<Orders>(
        builder: (ctx, orders, _) => ListView.builder(
          itemBuilder: (_, i) => OrderItemCard(orders.getByIndex(i)),
          itemCount: orders.count,
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
