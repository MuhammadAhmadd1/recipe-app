//the main screen where all the categories are displayed
import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal_structure.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widgets/category_grid_items.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key, required this.onToggelFavourite});
  final void Function(MealStructure meal) onToggelFavourite;

  void _selectScreen(BuildContext context, Category category) {
    final filteredMealList = dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meal: filteredMealList,
          onToggelFavourite: onToggelFavourite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.all(15),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: //availableCategories.map((category)=>CategoryGridItems(category: category)).toList(),
          [
        for (final category in availableCategories)
          CategoryGridItems(
            category: category,
            onSelectCategory: () {
              _selectScreen(context, category);
            },
          )
      ],
    );
  }
}
