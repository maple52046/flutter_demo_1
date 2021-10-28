import 'package:flutter/material.dart';
import 'package:udemy_demo_1/drawers/main_drawer.dart';
import 'package:udemy_demo_1/models/meal.dart';
import './category.dart';
import './favorite.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;
  TabsScreen(this.favoriteMeals);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  // final List<Widget> _pages = [
  //   CategoriesScreen(),
  //   FavoritesScreen(),
  // ];

  List<Map<String, Object>> _pages = [];
  int _selectedPage = 0;

  @override
  void initState() {
    _pages = [
      {'title': 'Categories', 'page': CategoriesScreen()},
      {
        'title': 'Your Favorites',
        'page': FavoritesScreen(widget.favoriteMeals)
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_pages[_selectedPage]['title'] as String),
          // bottom: TabBar(
          //   tabs: [
          //     Tab(
          //       icon: Icon(Icons.category),
          //       text: 'Categories',
          //     ),
          //     Tab(
          //       icon: Icon(Icons.star),
          //       text: 'Favorites',
          //     ),
          //   ],
          // ),
        ),
        // body: TabBarView(
        //   children: [CategoriesScreen(), FavoritesScreen()],
        // ),
        drawer: Drawer(
          child: MainDrawer(),
        ),
        body: _pages[_selectedPage]['page'] as Widget,
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.white,
          currentIndex: _selectedPage,
          backgroundColor: Theme.of(context).primaryColor,
          // type: BottomNavigationBarType.shifting,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Categories',
              // backgroundColor: Theme.of(context).primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'Favorites',
              // backgroundColor: Theme.of(context).accentColor,
            ),
          ],
        ),
      ),
    );
  }
}
