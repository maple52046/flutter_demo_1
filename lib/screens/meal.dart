import 'package:flutter/material.dart';
import 'package:udemy_demo_1/dummy_data.dart';
import 'package:udemy_demo_1/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  static const routeName = '/meals';

  // final String categoryId;
  // final String categoryTitle;
  // final Color categoryColor;

  // MealsScreen(
  //   this.categoryId,
  //   this.categoryTitle,
  //   this.categoryColor,
  // );

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    final categoryId = routeArgs['id'] as String;
    final categoryTitle = routeArgs['title'] as String;
    final categoryColor = Color(int.parse(routeArgs['color'] as String));

    final categoryMeals = DUMMY_MEALS
        .where((meal) => meal.categories.contains(categoryId))
        .toList();

    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle),
          backgroundColor: categoryColor,
        ),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(meal: categoryMeals[index]);
          },
          itemCount: categoryMeals.length,
        ));
  }
}
