import 'package:flutter/material.dart';
import 'package:udemy_demo_1/models/meal.dart';
import '../screens/meal_detail.dart';

class MealItem extends StatelessWidget {
  final Meal meal;
  final VoidCallback removeMeal;

  MealItem({required this.meal, required this.removeMeal});

  String get affordabilityText {
    switch (meal.affordability) {
      case Affordability.Affordable:
        return 'Affordable';
      case Affordability.Pricey:
        return 'Pricey';
      default:
        return 'Expensive';
    }
  }

  String get complexityText {
    switch (meal.complexity) {
      case Complexity.Simple:
        return 'Simple';
      case Complexity.Challenging:
        return 'Challenging';
      default:
        return 'Hard';
    }
  }

  void selectMeal(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(MealDetailScreen.routeName, arguments: meal);
    // .then((value) => removeMeal());
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = double.infinity;

    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.network(
                      meal.imgUrl,
                      height: 250,
                      width: maxWidth,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 10,
                    child: Container(
                      width: 220,
                      color: Colors.black54,
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Text(
                        meal.title,
                        style: const TextStyle(
                          fontSize: 26,
                          color: Colors.white,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.schedule),
                        const SizedBox(width: 6),
                        Text('${meal.duration} min'),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.work),
                        const SizedBox(width: 6),
                        Text(complexityText),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.attach_money),
                        const SizedBox(width: 6),
                        Text(affordabilityText),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
