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

  final String? title; // Optional title of the screen (used in the AppBar)
  final List<MealStructure> meal; // List of meals to display
  final void Function(MealStructure meal)
      onToggelFavourite; // Function to toggle favorite meals

  // Method to navigate to the meal details screen
  void _selectMealScreen(BuildContext context, MealStructure meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsDetailScreen(
          meal: meal,
          onToggelFavourite:
              onToggelFavourite, // Pass the favorite toggle function
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Default widget to display meals in a list
    Widget content = ListView.builder(
      itemCount: meal.length,
      itemBuilder: (ctx, index) => MealItem(
        meal: meal[index],
        onSelectMeal: (meal) {
          _selectMealScreen(
              context, meal); // Navigate to meal details screen on selection
        },
      ),
    );

    // If no meals are available, display a message
    if (meal.isEmpty) {
      content = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Empty ;(', // Displayed when no meals are available
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
            const SizedBox(height: 8),
            Text(
              'Nothing Here To Show', // Additional message
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      );
    }

    // If the title is null, return only the content (without AppBar)
    if (title == null) {
      return content;
    }

    // Otherwise, wrap content inside a Scaffold with an AppBar
    return Scaffold(
      appBar: AppBar(
        title: Text(title!), // Display the title in the AppBar
      ),
      body: content, // Display the list of meals or empty message
    );
  }
}
