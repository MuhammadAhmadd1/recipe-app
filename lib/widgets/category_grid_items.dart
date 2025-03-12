//blue print of all the categories

import 'package:flutter/material.dart';
import 'package:meals/models/category.dart'; // Importing the Category model

// A stateless widget that represents a single category item in a grid
class CategoryGridItems extends StatelessWidget {
  // Constructor with required parameters
  const CategoryGridItems({super.key, required this.category, required this.onSelectCategory});

  // The category data (title and color) passed to this widget
  final Category category;

  // A function that will be called when the category is tapped
  final void Function() onSelectCategory; 

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelectCategory, // Calls the function when the category is tapped
      splashColor: Theme.of(context).secondaryHeaderColor, // Splash effect color when tapped
      borderRadius: BorderRadius.circular(16), // Adds rounded corners to the InkWell effect

      child: Container(
        padding: EdgeInsets.all(12), // Adds padding inside the container
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14), // Rounded corners for the container
          
          // Background color with a gradient effect
          gradient: LinearGradient(
            colors: [
              category.color.withAlpha((0.55 * 255).toInt()), // Lighter version of the category color (55% opacity)
              category.color.withAlpha((0.9 * 255).toInt()), // Darker version of the category color (90% opacity)
            ],
            begin: Alignment.topLeft, // Gradient starts from the top left
            end: Alignment.bottomRight, // Gradient ends at the bottom right
          ),
        ),

        // Displays the category title
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface, // Text color based on theme
              ),
        ),
      ),
    );
  }
}
