import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/provider/meals_provider.dart';

// Enum representing different filter options
enum Filter { glutenFree, lactoseFree, vegetaraian, nonveg }

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetaraian: false,
          Filter.nonveg: false,
        });

  void setAllFilters(Map<Filter, bool> choosenFilters) {
    state = choosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filterProvider = StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
  (ref) => FilterNotifier(),
);

// Filter meals based on selected filters
final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filterProvider);

  return meals.where((meal) {
    // If gluten-free filter is enabled and meal is NOT gluten-free, exclude it
    if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    // If lactose-free filter is enabled and meal is NOT lactose-free, exclude it
    if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    // If vegetarian filter is enabled and meal is NOT vegetarian, exclude it
    if (activeFilters[Filter.vegetaraian]! && !meal.isVegetarian) {
      return false;
    }
    // If non-veg filter is enabled and meal is NOT non-veg, exclude it
    if (activeFilters[Filter.nonveg]! && !meal.isNonVeg) {
      return false;
    }
    return true; // Otherwise, include the meal
  }).toList();
});
