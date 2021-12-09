import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_demo_1/providers/products.dart';
import 'package:udemy_demo_1/constant.dart' as constant;

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/products/details';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final product =
        Provider.of<Products>(context, listen: false).getById(productId);

    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(product.imgUrl, fit: BoxFit.cover),
            ),
            const SizedBox(height: 10),
            Text(
              '\$${product.price}',
              style: const TextStyle(color: constant.grey, fontSize: 20),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                '${product.description}',
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
