import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_demo_1/providers/cart.dart';
import 'package:udemy_demo_1/providers/product.dart';
import 'package:udemy_demo_1/screens/product_detail_screen.dart';
import 'package:udemy_demo_1/constant.dart' as constant;

const _inCart = const Icon(Icons.shopping_cart, key: const Key('in_cart'));
const _notInCart = const Icon(
  Icons.shopping_cart_outlined,
  key: const Key('not_in_cart'),
);
const _isFavorite = const Icon(Icons.favorite, key: const Key('is_favorite'));
const _isNotFavorite = const Icon(
  Icons.favorite_outline,
  key: const Key('is_not_favorite'),
);

class ProductItem extends StatelessWidget {
  Widget shoppingCartBtn(
    BuildContext context,
    Product product,
    Color iconColor,
  ) {
    return Consumer<Cart>(
      builder: (ctx, cart, _) => IconButton(
        icon: cart.productInCart(product.id) ? _inCart : _notInCart,
        color: iconColor,
        onPressed: () {
          print('add ${product.title} to cart...');
          cart.addItem(product);
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Added ${product.title} to cart',
                textAlign: TextAlign.center,
              ),
              duration: const Duration(seconds: 2),
              action: SnackBarAction(
                label: 'UNDO',
                onPressed: () {
                  cart.reduceItem(product.id);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).colorScheme.secondary;
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
            backgroundColor: constant.navyBlueColors[600],
            leading: IconButton(
              icon: product.isFavorite ? _isFavorite : _isNotFavorite,
              color: iconColor,
              onPressed: () {
                product.toggleFavoriteStatus();
              },
            ),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            trailing: shoppingCartBtn(context, product, iconColor),
          ),
        ),
      ),
    );
  }
}
