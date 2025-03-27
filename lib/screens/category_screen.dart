import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal_structure.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widgets/category_grid_items.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({
    super.key,
    required this.availableFilteredMeals, // List of meals available after applying filters.
  });

  final List<MealStructure> availableFilteredMeals;
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      //0 and 1 are also the default values
      lowerBound: 0,
      upperBound: 1,
    );
    //to start the animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Filtered list of meals.
  void _selectScreen(BuildContext context, Category category) {
    // Filtering the list of meals to include only those that belong to the selected category.
    final filteredMealList = widget.availableFilteredMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    // Navigating to the MealsScreen and passing the filtered meal list.
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title:
              category.title, // Passing the category title as the screen title.
          meal: filteredMealList, // Passing the filtered meal list.
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        padding: EdgeInsets.all(20), // Adding padding around the grid.
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Setting the grid to have 2 columns.
          childAspectRatio:
              3 / 2, // Defining the aspect ratio of each grid item.
          crossAxisSpacing: 20, // Spacing between columns.
          mainAxisSpacing: 20, // Spacing between rows.
        ),
        children: [
          // Looping through available categories and creating grid items for each.
          for (final category in availableCategories)
            CategoryGridItems(
              category: category, // Passing category data to the widget.
              onSelectCategory: () {
                _selectScreen(context,
                    category); // Calling the function when a category is selected.
              },
            )
        ],
      ),
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.3),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        ),
        child: child,
      ),
    );
  }
}
