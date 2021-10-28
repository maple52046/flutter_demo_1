import 'dart:core';
import 'package:flutter/material.dart';
import 'package:udemy_demo_1/models/meal.dart';
import 'package:udemy_demo_1/widgets/meal_item.dart';

class MealsScreen extends StatefulWidget {
  static const routeName = '/meals';
  final List<Meal> availableMeals;

  MealsScreen(this.availableMeals);

  @override
  _MealsScreenState createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  String? categoryTitle;
  Color? categoryColor;
  List<Meal> categoryMeals = [];
  var _loadedInitData = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      final categoryId = routeArgs['id'] as String;
      categoryTitle = routeArgs['title'] as String;
      categoryColor = Color(int.parse(routeArgs['color'] as String));
      categoryMeals = widget.availableMeals
          .where((meal) => meal.categories.contains(categoryId))
          .toList();
      _loadedInitData = true;
    }

    super.didChangeDependencies();
  }

  void _removeMeal(int index) {
    setState(() {
      categoryMeals.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle as String),
        backgroundColor: categoryColor,
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            meal: categoryMeals[index],
            removeMeal: () {
              _removeMeal(index);
            },
          );
        },
        itemCount: categoryMeals.length,
      ),
      // body: MealList(categoryMeals, _removeMeal),
    );
  }
}
