import 'package:flutter/material.dart';

// A stateless widget representing the main navigation drawer.
class MainDrawer extends StatelessWidget {
  // Constructor that takes a callback function to handle screen selection.
  const MainDrawer({super.key, required this.onSelectScreen});

  // A function that takes an identifier string and performs an action.
  final void Function(String identifier) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // A column layout to arrange children vertically.
      child: Column(
        children: [
          // Drawer header with a gradient background.
          DrawerHeader(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  // Using secondaryContainer color with some transparency.
                  Theme.of(context)
                      .colorScheme
                      .secondaryContainer
                      .withAlpha((0.8 * 255).toInt()),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                // An icon representing food.
                Icon(
                  Icons.fastfood,
                  size: 48,
                ),
                SizedBox(
                  width: 18, // Spacing between icon and text.
                ),
                // Title text with theme styling.
                Text(
                  'Coocking up!',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
          // List tile for navigating to the "Meals" screen.
          ListTile(
            leading: Icon(
              Icons.restaurant,
              size: 26,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            title: Text(
              'Meal',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 24,
                  ),
            ),
            // Calls the onSelectScreen function with 'meals' when tapped.
            onTap: () {
              onSelectScreen('meals');
            },
          ),
          // List tile for navigating to the "Filters" screen.
          ListTile(
            leading: Icon(
              Icons.filter_alt_sharp,
              size: 26,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            title: Text(
              'Filters',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 24,
                  ),
            ),
            // Calls the onSelectScreen function with 'filters' when tapped.
            onTap: () {
              onSelectScreen('filters');
            },
          ),
        ],
      ),
    );
  }
}
