import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_demo_1/providers/product.dart';
import 'package:udemy_demo_1/providers/products.dart';
import 'package:udemy_demo_1/widgets/app_drawer.dart';
import 'package:udemy_demo_1/widgets/user_product_item.dart';
import './edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({Key? key}) : super(key: key);
  static const routeName = '/users/products';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(
                EditProductScreen.routeName,
                arguments: new Product(
                  id: '',
                  title: '',
                  imgUrl: '',
                  price: 0,
                  description: '',
                ),
              );
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Consumer<Products>(
        builder: (ctx, products, _) => Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: products.items.length,
            itemBuilder: (_, i) => Column(
              children: [
                UserProductItem(
                  product: products.items[i],
                  onDelete: () {
                    products.removeProductById(i);
                  },
                ),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
