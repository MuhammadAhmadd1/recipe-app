//to show all the meals for the selected category

import 'package:flutter/material.dart';
import 'package:meals/models/meal_structure.dart';
import 'package:meals/screens/meals_detail_screen.dart';
import 'package:meals/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meal,
    required this.onToggelFavourite,
  });

  final String? title;
  final List<MealStructure> meal;
  final void Function(MealStructure meal) onToggelFavourite;

  void _selectMealScreen(BuildContext context, MealStructure meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsDetailScreen(
          meal: meal,
          onToggelFavourite: onToggelFavourite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meal.length,
      itemBuilder: (ctx, index) => MealItem(
        meal: meal[index],
        onSelectMeal: (meal) {
          _selectMealScreen(context, meal);
        },
      ),
    );

    if (meal.isEmpty) {
      content = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Empty ;(',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
            const SizedBox(height: 16),
            Text(
              'No Meal Marked As Favorite',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      );
    }
    if (title == null) {
      return content;
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(title!),
      ),
      body: content,
    );
  }
}
