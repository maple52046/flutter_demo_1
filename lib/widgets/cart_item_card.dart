import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_demo_1/providers/cart.dart';

class CartItemCard extends StatelessWidget {
  final CartItem item;

  CartItemCard(this.item);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(item.id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(Icons.delete, color: Colors.white, size: 40),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 10),
        // margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        Provider.of<Cart>(context, listen: false).removeItem(item.productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Container(
                padding: EdgeInsets.all(2),
                child: FittedBox(child: Text('\$${item.price}')),
              ),
            ),
            title: Text(item.title),
            subtitle: Text('Total: \$${item.amount}'),
            trailing: Text('${item.quantity} x'),
          ),
        ),
      ),
    );
  }
}
