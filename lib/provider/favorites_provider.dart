import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal_structure.dart';

class FavoriteMealsNotifier extends StateNotifier<List<MealStructure>> {
  FavoriteMealsNotifier() : super([]);

  void toggleMealFavouriteStatus(MealStructure meal) {
    final mealIsFavorite = state.contains(meal);

    if (mealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
    } else {
      state = [...state, meal];
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<MealStructure>>(
  (ref) {
    return FavoriteMealsNotifier();
  },
);
