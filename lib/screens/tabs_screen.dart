import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal_structure.dart';
import 'package:meals/screens/category_screen.dart';
import 'package:meals/screens/filters_screen.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widgets/main_drawer.dart';

// Initial filter settings with default values
const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetaraian: false, // Typo in 'vegetarian'
  Filter.nonveg: false,
};

// Main screen that manages tabs and filtering
class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectPageIndex = 0; // Tracks the currently selected tab index
  final List<MealStructure> _isFavourite = []; // List of favorite meals
  Map<Filter, bool> _selectedFilters = kInitialFilters; // Stores applied filters

  // Function to show a snackbar message
  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars(); // Clear previous snackbars
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 1),
      ),
    );
  }

  // Function to toggle meal favorite status
  void _toggleFavouriteMealStatus(MealStructure meal) {
    final isExisting = _isFavourite.contains(meal);
    if (isExisting) {
      setState(() {
        _isFavourite.remove(meal);
      });
      _showInfoMessage('Unmarked As Favourite!');
    } else {
      setState(() {
        _isFavourite.add(meal);
      });
      _showInfoMessage('Marked As Favourite!');
    }
  }

  // Function to switch between tabs
  void selectPage(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  // Function to navigate to another screen (e.g., Filters screen)
  void _setScreen(String identifier) async {
    Navigator.of(context).pop(); // Close drawer
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
            currentFilter: _selectedFilters,
          ),
        ),
      );
      setState(() {
        _selectedFilters = result ?? kInitialFilters; // Update filters if available
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filter meals based on selected filters
    final availableMeals = dummyMeals.where((meal) {
      // If gluten-free filter is enabled and meal is NOT gluten-free, exclude it
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      // If lactose-free filter is enabled and meal is NOT lactose-free, exclude it
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      // If vegetarian filter is enabled and meal is NOT vegetarian, exclude it
      if (_selectedFilters[Filter.vegetaraian]! && !meal.isVegetarian) {
        return false;
      }
      // If non-veg filter is enabled and meal is NOT non-veg, exclude it
      if (_selectedFilters[Filter.nonveg]! && !meal.isNonVeg) {
        return false;
      }
      return true; // Otherwise, include the meal
    }).toList();

    // Default active page is CategoryScreen
    Widget activePage = CategoryScreen(
      onToggelFavourite: _toggleFavouriteMealStatus,
      availableFilteredMeals: availableMeals,
    );
    var activePageTitle = 'Category';

    // If the selected tab index is 1, switch to Favorites tab
    if (_selectPageIndex == 1) {
      activePage = MealsScreen(
        meal: _isFavourite,
        onToggelFavourite: _toggleFavouriteMealStatus,
      );
      activePageTitle = 'Favorite';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      drawer: MainDrawer(
        onSelectScreen: _setScreen, // Opens filter screen when selected
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectPage, // Switches between tabs
        currentIndex: _selectPageIndex, // Highlights selected tab
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Category'), // Category tab
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorite'), // Favorite tab
        ],
      ),
    );
  }
}
