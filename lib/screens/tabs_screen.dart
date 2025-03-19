import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/screens/category_screen.dart';
import 'package:meals/screens/filters_screen.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:meals/provider/favorites_provider.dart';
import 'package:meals/provider/filter_provider.dart';

// Initial filter settings with default values
const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetaraian: false, // Typo in 'vegetarian'
  Filter.nonveg: false,
};

// Main screen that manages tabs and filtering
class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectPageIndex = 0; // Tracks the currently selected tab index

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
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //makes sure that our Build method executes again as our data changes
    final availableMeals = ref.watch(filteredMealsProvider);

    // Default active page is CategoryScreen
    Widget activePage = CategoryScreen(
      availableFilteredMeals: availableMeals,
    );
    var activePageTitle = 'Category';

    // If the selected tab index is 1, switch to Favorites tab
    if (_selectPageIndex == 1) {
      final favouriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meal: favouriteMeals,
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
          BottomNavigationBarItem(
              icon: Icon(Icons.star), label: 'Favorite'), // Favorite tab
        ],
      ),
    );
  }
}
