import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal_structure.dart';

class FavoriteMealsNotifier extends StateNotifier<List<MealStructure>> {
  FavoriteMealsNotifier() : super([]);

  bool toggleMealFavouriteStatus(MealStructure meal) {
    final mealIsFavorite = state.contains(meal);

    if (mealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<MealStructure>>(
  (ref) {
    return FavoriteMealsNotifier();
  },
);
