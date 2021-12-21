import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_demo_1/providers/product.dart';
import 'package:udemy_demo_1/providers/products.dart';
import 'package:udemy_demo_1/screens/edit_product_screen.dart';
import 'package:udemy_demo_1/constant.dart' as constant;

class UserProductItem extends StatefulWidget {
  final Product product;
  UserProductItem(this.product);

  @override
  State<UserProductItem> createState() => _UserProductItemState();
}

class _UserProductItemState extends State<UserProductItem> {
  var _isLoading = false;

  void onDelete(BuildContext ctx) {
    setState(() {
      _isLoading = true;
    });
    Provider.of<Products>(ctx, listen: false).removeProduct(widget.product);
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: const CircularProgressIndicator.adaptive())
        : ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(widget.product.imgUrl),
            ),
            title: Text(widget.product.title),
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
                        arguments: widget.product,
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () => onDelete(context),
                  ),
                ],
              ),
            ),
          );
  }
}
