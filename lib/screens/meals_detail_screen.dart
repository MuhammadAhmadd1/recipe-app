import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal_structure.dart';
import 'package:meals/provider/favorites_provider.dart';

// This widget displays the details of a meal.
class MealsDetailScreen extends ConsumerWidget {
  const MealsDetailScreen({
    super.key,
    required this.meal,
  });

  // The meal whose details will be displayed.
  final MealStructure meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favMeal = ref.watch(favoriteMealsProvider);
    final isFavourite = favMeal.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title), // Display the meal title in the app bar.
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(favoriteMealsProvider.notifier)
                  .toggleMealFavouriteStatus(meal);
              ScaffoldMessenger.of(context)
                  .clearSnackBars(); // Clear previous snackbars
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(wasAdded
                      ? 'Marked As Favourite!'
                      : 'UnMarked As Favourite!'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            icon: Icon(
              isFavourite ? Icons.star : Icons.star_border,
            ), // Star icon for marking favorite.
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
