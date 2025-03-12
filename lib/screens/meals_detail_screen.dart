import 'package:flutter/material.dart';
import 'package:meals/models/meal_structure.dart';

// This widget displays the details of a meal.
class MealsDetailScreen extends StatelessWidget {
  const MealsDetailScreen({
    super.key,
    required this.meal,
    required this.onToggelFavourite,
  });

  // The meal whose details will be displayed.
  final MealStructure meal;

  // Function to toggle the meal as favorite.
  final void Function(MealStructure meal) onToggelFavourite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title), // Display the meal title in the app bar.
        actions: [
          IconButton(
            onPressed: () {
              onToggelFavourite(meal); // Call the function to toggle favorite.
            },
            icon: Icon(Icons.star), // Star icon for marking favorite.
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Display the meal image.
              Image.network(
                meal.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 12),

              // Section title for ingredients.
              Text(
                'Ingredients',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(height: 8),

              // Display each ingredient.
              for (final ingredient in meal.ingredients)
                Text(
                  ingredient,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Theme.of(context).colorScheme.onSurface),
                ),
              const SizedBox(height: 14),

              // Section title for instructions.
              Text(
                'Instructions',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(height: 8),

              // Display each step of the meal preparation.
              for (final instructions in meal.steps)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Text(
                    instructions,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
