import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_demo_1/providers/cart.dart';
import 'package:udemy_demo_1/providers/product.dart';
import 'package:udemy_demo_1/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  // final Product product;
  // ProductItem(this.product);

  Widget shoppingCartBtn(Product product, Color iconColor) {
    return Consumer<Cart>(
      builder: (ctx, cart, _) => IconButton(
        icon: Icon(
          cart.productInCart(product.id)
              ? Icons.shopping_cart
              : Icons.shopping_cart_outlined,
        ),
        color: iconColor,
        onPressed: () {
          print('add ${product.title} to cart...');
          cart.addItem(product);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).accentColor;
    final product = Provider.of<Product>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            ProductDetailScreen.routeName,
            arguments: product.id,
          );
        },
        child: GridTile(
          child: Image.network(
            product.imgUrl,
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            backgroundColor: const Color.fromRGBO(33, 47, 61, 0.7),
            leading: IconButton(
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_outline),
              color: iconColor,
              onPressed: () {
                product.toggleFavoriteStatus();
              },
            ),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            trailing: shoppingCartBtn(product, iconColor),
          ),
        ),
      ),
    );
  }
}
