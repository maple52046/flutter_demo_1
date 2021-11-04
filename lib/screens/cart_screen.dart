import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_demo_1/providers/cart.dart' as crt;
import 'package:udemy_demo_1/providers/orders.dart' as ord;
import 'package:udemy_demo_1/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  static const routeName = '/cart';

  Widget buildItems(Iterable<crt.CartItem> items, Function(String) deletion) {
    List<crt.CartItem> values = items.toList();
    return Expanded(
      child: ListView.builder(
        itemCount: values.length,
        itemBuilder: (ctx, i) => CartItem(values[i]),
      ),
    );
  }

  Widget buildTotalCount(BuildContext context, crt.Cart cart) {
    return Card(
      margin: const EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Total', style: TextStyle(fontSize: 20)),
            const SizedBox(width: 10),
            Chip(
              label: Text(
                '\$${cart.totalAmount.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Theme.of(context).primaryTextTheme.headline1!.color,
                ),
              ),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            TextButton(
              child: Text(
                'Order NOW',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onPressed: () {
                Provider.of<ord.Orders>(context, listen: false).addOrder(
                  cart.items.values,
                  cart.totalAmount,
                );
                cart.removeAll();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body: Consumer<crt.Cart>(
        builder: (ctx, cart, _) => Column(
          children: [
            buildTotalCount(context, cart),
            buildItems(cart.items.values, cart.removeItem),
          ],
        ),
      ),
    );
  }
}
