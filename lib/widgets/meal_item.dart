// Import necessary Flutter packages
import 'package:flutter/material.dart';
import 'package:meals/models/meal_structure.dart'; // Import the meal model
import 'package:meals/widgets/meal_item_trait.dart'; // Import a custom widget for displaying meal traits
import 'package:transparent_image/transparent_image.dart'; // Package to show a transparent placeholder while an image loads

// Stateless widget to display a meal item
class MealItem extends StatelessWidget {
  // Constructor with required meal data and a function callback
  const MealItem({super.key, required this.meal, required this.onSelectMeal});

  // Meal data to be displayed
  final MealStructure meal;

  // Callback function to handle meal selection
  final void Function(MealStructure meal) onSelectMeal;

  // Getter to format and capitalize meal complexity text
  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  // Getter to format and capitalize meal affordability text
  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5), // Add margin around the card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Round card corners
      ),
      clipBehavior: Clip.hardEdge, // Clip content to rounded shape
      elevation: 2, // Add slight shadow effect
      child: InkWell(
        onTap: () {
          onSelectMeal(meal); // Call the function when tapped
        },
        child: Stack(
          children: [
            // Fade-in effect when loading an image
            FadeInImage(
              placeholder: MemoryImage(
                  kTransparentImage), // Transparent placeholder while loading
              image: NetworkImage(meal.imageUrl), // Load image from the URL
              fit: BoxFit.cover, // Ensure the image covers the space properly
              height: 200,
              width: double.infinity, // Expand to full width
            ),

            // Overlay a semi-transparent container at the bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54, // Dark background for text contrast
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    // Display meal title
                    Text(
                      meal.title,
                      maxLines: 2, // Allow up to two lines
                      textAlign: TextAlign.center,
                      softWrap: true, // Wrap text within available space
                      overflow: TextOverflow
                          .ellipsis, // Show '...' if text is too long
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors
                            .white, // Ensure text is visible on dark background
                      ),
                    ),
                    const SizedBox(
                        height: 12), // Add space between title and traits row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Display duration trait
                        MealItemTrait(
                          icon: Icons.schedule,
                          lable: '${meal.duration} min',
                        ),
                        SizedBox(width: 12), // Space between items

                        // Display complexity trait
                        MealItemTrait(
                          icon: Icons.work,
                          lable: '$complexityText ',
                        ),
                        SizedBox(width: 12),

                        // Display affordability trait
                        MealItemTrait(
                          icon: Icons.attach_money,
                          lable: '$affordabilityText ',
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
