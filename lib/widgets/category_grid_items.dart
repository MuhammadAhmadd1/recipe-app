//blue print of all the categories

import 'package:flutter/material.dart';
import 'package:meals/models/category.dart';

class CategoryGridItems extends StatelessWidget {
  const CategoryGridItems({super.key, required this.category});
  final Category category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            category.color.withAlpha((0.55 * 255).toInt()),
            category.color.withAlpha((0.9 * 255).toInt()),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Text(
        category.title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
    );
  }
}
