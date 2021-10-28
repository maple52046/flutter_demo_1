import 'package:flutter/material.dart';
import 'dummy_data.dart';
import 'models/meal.dart';
import 'screens/filter.dart';
import 'screens/meal.dart';
import 'screens/meal_detail.dart';
import 'screens/tab.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  bool _isFavoriteMeal(String mealId) {
    return _favoriteMeals.any((meal) => meal.id == mealId);
  }

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose']! && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan']! && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian']! && meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final index = _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    setState(() {
      if (index >= 0) {
        _favoriteMeals.removeAt(index);
      } else {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              bodyText2: const TextStyle(color: Color.fromRGBO(20, 51, 15, 1)),
              headline1: const TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      initialRoute: '/',
      routes: {
        // '/': (ctx) => CategoriesScreen(),
        '/': (ctx) => TabsScreen(_favoriteMeals),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
        MealsScreen.routeName: (ctx) => MealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(
              _isFavoriteMeal,
              _toggleFavorite,
            ),
      },
      onGenerateRoute: (settings) {
        // print(settings.arguments);
        print('route: ${settings.name}');
        // return MaterialPageRoute(builder: (ctx) => MealsScreen());
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => TabsScreen(_favoriteMeals));
      },
    );
  }
}
