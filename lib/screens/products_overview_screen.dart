import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_demo_1/providers/cart.dart';
import 'package:udemy_demo_1/providers/products.dart';
import 'package:udemy_demo_1/widgets/app_drawer.dart';
import 'package:udemy_demo_1/widgets/badge.dart';
import 'package:udemy_demo_1/widgets/products_grid.dart';
import 'cart_screen.dart';

enum FilterOptions {
  FavoriteOnly,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  // final List<Product> products = [];

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _isLoading = true;

  @override
  void didChangeDependencies() {
    if (_isLoading) {
      print('loading data in dependencies hook');
      Provider.of<Products>(context)
          .fetchItems()
          .then((_) => setState(() {
                _isLoading = false;
                print('data loaded');
              }))
          .catchError(
            (err) => showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                      title: const Text('Fetch Product List Failed'),
                      content: Text(err.toString()),
                      actions: [
                        TextButton(
                          child: const Text('Close'),
                          onPressed: () {
                            setState(() {
                              _isLoading = false;
                            });
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    )),
          )
          .then((_) => print('final'));
    }
    super.didChangeDependencies();
  }

  Widget buildCart(BuildContext context) {
    return Consumer<Cart>(
      builder: (ctx, cart, _) => Badge(
        child: IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {
            Navigator.of(context).pushNamed(CartScreen.routeName);
          },
        ),
        value: cart.count.toString(),
      ),
    );
  }

  Widget buildMenu() {
    return Consumer<Products>(
      builder: (ctx, products, _) => PopupMenuButton(
        icon: Icon(Icons.more_vert),
        itemBuilder: (ctx) => const [
          PopupMenuItem(
            child: Text('Only Favorites!'),
            value: FilterOptions.FavoriteOnly,
          ),
          PopupMenuItem(
            child: Text('Show all'),
            value: FilterOptions.All,
          ),
        ],
        onSelected: (FilterOptions value) {
          switch (value) {
            case FilterOptions.FavoriteOnly:
              products.showFavoriteOnly();
              break;
            case FilterOptions.All:
              products.showAll();
              break;
            default:
              print('unexpected selection: $value');
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        actions: [
          buildMenu(),
          buildCart(context),
        ],
      ),
      body: _isLoading
          ? const Center(child: const CircularProgressIndicator.adaptive())
          : ProductsGrid(),
      drawer: const AppDrawer(),
    );
  }
}
