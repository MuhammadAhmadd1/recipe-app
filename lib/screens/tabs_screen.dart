import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal_structure.dart';
import 'package:meals/screens/category_screen.dart';
import 'package:meals/screens/filters_screen.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widgets/main_drawer.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetaraian: false,
  Filter.nonveg: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectPageIndex = 0;
  final List<MealStructure> _isFavourite = [];
  Map<Filter, bool> _selectedFilters = kInitialFilters;

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 1),
      ),
    );
  }

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

  void selectPage(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
            currentFilter: _selectedFilters,
          ),
        ),
      );
      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      //if I only want to show gluten-free meals & this meal is not
      //gluten-free then retuen false
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegetaraian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filter.nonveg]! && !meal.isNonVeg) {
        return false;
      }
      //If the meals meet the statment above and are false
      //then they will be true and executed
      return true;
    }).toList();
    Widget activePage = CategoryScreen(
      onToggelFavourite: _toggleFavouriteMealStatus,
      availableFilteredMeals: availableMeals,
    );
    var activePageTitle = 'Category';

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
        onSelectScreen: _setScreen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectPage,
        currentIndex: _selectPageIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Category'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorite'),
        ],
      ),
    );
  }
}
