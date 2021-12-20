import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_demo_1/providers/products.dart';

import 'product_item.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pData = Provider.of<Products>(context);
    final products = pData.items;
    return products.length == 0
        ? const Center(child: const Text('No Data'))
        : GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 3 / 2,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
              value: products[i],
              child: ProductItem(),
            ),
            itemCount: products.length,
          );
  }
}
