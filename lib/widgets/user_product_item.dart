import 'package:flutter/material.dart';
import 'package:udemy_demo_1/providers/product.dart';
import 'package:udemy_demo_1/screens/edit_product_screen.dart';
import 'package:udemy_demo_1/constant.dart' as constant;

class UserProductItem extends StatelessWidget {
  final Product product;
  final VoidCallback onDelete;
  UserProductItem({required this.product, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(product.imgUrl)),
      title: Text(product.title),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              color: constant.grey,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  EditProductScreen.routeName,
                  arguments: product,
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
