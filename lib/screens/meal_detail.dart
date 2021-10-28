import 'package:flutter/material.dart';
import 'package:udemy_demo_1/models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meals/detail';
  final Function(String) isFavorite;
  final Function(String) toggleFavorite;

  MealDetailScreen(this.isFavorite, this.toggleFavorite);

  Widget buildSectionTitle(BuildContext ctx, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(ctx).textTheme.headline1,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Meal meal = ModalRoute.of(context)!.settings.arguments as Meal;
    final IconData favIcon =
        isFavorite(meal.id) ? Icons.star : Icons.star_outline_outlined;

    return Scaffold(
      appBar: AppBar(
        title: Text('${meal.title}'),
        backgroundColor: const Color.fromRGBO(44, 44, 44, 1),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                meal.imgUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Card(
                  color: Theme.of(context).accentColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    child: Text(meal.ingredients[index]),
                  ),
                ),
                itemCount: meal.ingredients.length,
              ),
            ),
            buildSectionTitle(context, 'Steps'),
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(child: Text('# ${(index + 1)}')),
                      title: Text(meal.steps[index]),
                    ),
                    const Divider(),
                  ],
                ),
                itemCount: meal.steps.length,
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.delete),
      //   onPressed: () {
      //     // Navigator.of(context).popAndPushNamed('/');
      //     Navigator.of(context).pop(meal);
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        child: Icon(favIcon),
        onPressed: () {
          toggleFavorite(meal.id);
        },
      ),
    );
  }
}
