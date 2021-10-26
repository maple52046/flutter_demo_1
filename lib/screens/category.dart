import 'package:flutter/material.dart';
import 'package:udemy_demo_1/widgets/category_item.dart';
import 'package:udemy_demo_1/dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.all(25),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: DUMMY_CATEGORIES
          .map((data) => CategoryItem(
                id: data.id,
                title: data.title,
                color: data.color,
              ))
          .toList(),
    );
  }
}
