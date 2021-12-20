import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './providers/products.dart';
import './screens/cart_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/orders_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/products_overflow_screen.dart';
import './screens/user_products_screen.dart';
import './constant.dart' as constant;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProvider(create: (ctx) => Products()),
        ChangeNotifierProvider(create: (ctx) => Orders()),
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          appBarTheme: AppBarTheme(backgroundColor: constant.purple),
          bottomAppBarColor: constant.purple,
          colorScheme: const ColorScheme.light(
            onError: constant.red,
            secondary: constant.deepOrange,
          ),
          fontFamily: 'Lato',
          primarySwatch: constant.purpleColor,
        ),
        home: ProductsOverviewScreen(),
        routes: {
          CartScreen.routeName: (ctx) => CartScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
        },
      ),
    );
  }
}
