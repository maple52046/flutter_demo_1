import 'package:flutter/material.dart';
import 'package:udemy_demo_1/screens/meal.dart';

class CategoryItem extends StatelessWidget {
  // const CategoryItem({Key? key}) : super(key: key);

  final String id;
  final String title;
  final Color color;

  CategoryItem({
    required this.id,
    required this.title,
    required this.color,
  });

  // void selectCategory(BuildContext ctx) {
  //   Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
  //     return MealsScreen(id, title, color);
  //   }));
  // }

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(MealsScreen.routeName, arguments: {
      'id': id,
      'title': title,
      'color': color.value.toString(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline1,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.3), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
