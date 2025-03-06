import 'package:flutter/material.dart';
import 'package:meals/models/meal_structure.dart';
import 'package:meals/screens/category_screen.dart';
import 'package:meals/screens/meals_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectPageIndex = 0;
  final List<MealStructure> _isFavourite = [];

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

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoryScreen(
      onToggelFavourite: _toggleFavouriteMealStatus,
    );
    var activePageTitle = 'Category';

    if (_selectPageIndex == 1) {
      activePage = MealsScreen(
        meal: _isFavourite,
        onToggelFavourite: _toggleFavouriteMealStatus,
      );
      activePageTitle = 'Favourite';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectPage,
        currentIndex: _selectPageIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Category'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favourite'),
        ],
      ),
    );
  }
}
