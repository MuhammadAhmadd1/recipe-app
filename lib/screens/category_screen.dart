import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart'; // Importing dummy data that contains predefined categories.
import 'package:meals/models/category.dart'; // Importing the Category model.
import 'package:meals/models/meal_structure.dart'; // Importing the MealStructure model.
import 'package:meals/screens/meals_screen.dart'; // Importing the screen where meals will be displayed.
import 'package:meals/widgets/category_grid_items.dart'; // Importing the widget used to display categories as grid items.

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({
    super.key,
    required this.availableFilteredMeals, // List of meals available after applying filters.
  });

  final List<MealStructure> availableFilteredMeals; // Filtered list of meals.

  // Function to navigate to the MealsScreen when a category is selected.
  void _selectScreen(BuildContext context, Category category) {
    // Filtering the list of meals to include only those that belong to the selected category.
    final filteredMealList = availableFilteredMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    // Navigating to the MealsScreen and passing the filtered meal list.
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title, // Passing the category title as the screen title.
          meal: filteredMealList, // Passing the filtered meal list.
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.all(15), // Adding padding around the grid.
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Setting the grid to have 2 columns.
        childAspectRatio: 3 / 2, // Defining the aspect ratio of each grid item.
        crossAxisSpacing: 20, // Spacing between columns.
        mainAxisSpacing: 20, // Spacing between rows.
      ),
      children: [
        // Looping through available categories and creating grid items for each.
        for (final category in availableCategories)
          CategoryGridItems(
            category: category, // Passing category data to the widget.
            onSelectCategory: () {
              _selectScreen(context, category); // Calling the function when a category is selected.
            },
          )
      ],
    );
  }
}
