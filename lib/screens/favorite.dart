import 'package:flutter/material.dart';
import 'package:udemy_demo_1/models/meal.dart';
import 'package:udemy_demo_1/widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;
  FavoritesScreen(this.favoriteMeals);

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return const Center(
        child: Text('You have no favoriates yet - start add some!'),
      );
    }

    return ListView.builder(
      itemBuilder: (ctx, index) {
        return MealItem(
          meal: favoriteMeals[index],
          removeMeal: () {
            print('do nothing');
          },
        );
      },
      itemCount: favoriteMeals.length,
    );
  }
}
