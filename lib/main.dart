import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_demo_1/providers/cart.dart';
import 'package:udemy_demo_1/providers/orders.dart';
import 'package:udemy_demo_1/screens/cart_screen.dart';
import 'package:udemy_demo_1/screens/orders_screen.dart';
import './providers/products.dart';
import './screens/product_detail_screen.dart';
import './screens/products_overflow_screen.dart';

Map<int, Color> deepOrangeColor = const {
  50: Color.fromRGBO(255, 87, 51, .1),
  100: Color.fromRGBO(255, 87, 51, .2),
  200: Color.fromRGBO(255, 87, 51, .3),
  300: Color.fromRGBO(255, 87, 51, .4),
  400: Color.fromRGBO(255, 87, 51, .5),
  500: Color.fromRGBO(255, 87, 51, .6),
  600: Color.fromRGBO(255, 87, 51, .7),
  700: Color.fromRGBO(255, 87, 51, .8),
  800: Color.fromRGBO(255, 87, 51, .9),
  900: Color.fromRGBO(255, 87, 51, 1),
};

Map<int, Color> purpleColor = const {
  50: Color.fromRGBO(108, 52, 131, .1),
  100: Color.fromRGBO(108, 52, 131, .2),
  200: Color.fromRGBO(108, 52, 131, .3),
  300: Color.fromRGBO(108, 52, 131, .4),
  400: Color.fromRGBO(108, 52, 131, .5),
  500: Color.fromRGBO(108, 52, 131, .6),
  600: Color.fromRGBO(108, 52, 131, .7),
  700: Color.fromRGBO(108, 52, 131, .8),
  800: Color.fromRGBO(108, 52, 131, .9),
  900: Color.fromRGBO(108, 52, 131, 1),
};

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final purple = MaterialColor(0xFF6C3483, purpleColor);
    // final deepOrange = MaterialColor(0xFFFF5733, deepOrangeColor);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProvider(create: (ctx) => Products()),
        ChangeNotifierProvider(create: (ctx) => Orders()),
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: purple,
          accentColor: deepOrangeColor[900],
          fontFamily: 'Lato',
          bottomAppBarColor: purpleColor[900],
        ),
        home: ProductsOverflowScreen(),
        routes: {
          CartScreen.routeName: (ctx) => CartScreen(),
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
        },
      ),
    );
  }
}

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('MyShop'),
//       ),
//       body: Center(
//         child: Text('Let\'s build a shop!'),
//       ),
//     );
//   }
// }
