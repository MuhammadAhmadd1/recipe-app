import 'package:flutter/material.dart';

// Enum representing different filter options
enum Filter { glutenFree, lactoseFree, vegetaraian, nonveg }

// Stateful widget to manage filters screen
class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentFilter});

  // Map to store the current filter settings passed from the parent widget
  final Map<Filter, bool> currentFilter;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  // Variables to hold the state of each filter switch
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegetaraianFilterSet = false;
  var _nonVegFilterSet = false;

  @override
  void initState() {
    super.initState();
    // Initialize the switch states from the passed current filter settings
    _glutenFreeFilterSet = widget.currentFilter[Filter.glutenFree]!;
    _lactoseFreeFilterSet = widget.currentFilter[Filter.lactoseFree]!;
    _vegetaraianFilterSet = widget.currentFilter[Filter.vegetaraian]!;
    _nonVegFilterSet = widget.currentFilter[Filter.nonveg]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
      ),
      // PopScope prevents accidental back navigation without saving filters
      body: PopScope(
        canPop: false, // Disables default back navigation
        onPopInvokedWithResult: (bool didPop, dynamic result) {
          if (didPop) return; // If user has already popped, return early
          
          // Pass updated filter settings back when navigating away
          Navigator.of(context).pop({
            Filter.glutenFree: _glutenFreeFilterSet,
            Filter.lactoseFree: _lactoseFreeFilterSet,
            Filter.vegetaraian: _vegetaraianFilterSet,
            Filter.nonveg: _nonVegFilterSet,
          });
        },
        child: Column(
          children: [
            // Switch to enable or disable Gluten-free filter
            SwitchListTile(
              value: _glutenFreeFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _glutenFreeFilterSet = isChecked;
                });
              },
              title: Text(
                'Gluten-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              subtitle: Text(
                'Only Include Gluten-free Meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              activeColor: Colors.green,
              contentPadding: EdgeInsets.only(left: 34, right: 22),
            ),

            // Switch to enable or disable Lactose-free filter
            SwitchListTile(
              value: _lactoseFreeFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _lactoseFreeFilterSet = isChecked;
                });
              },
              title: Text(
                'Lactose-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              subtitle: Text(
                'Only Include Lactose-free Meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              activeColor: Colors.green,
              contentPadding: EdgeInsets.only(left: 34, right: 22),
            ),

            // Switch to enable or disable Vegetarian filter (contains a typo)
            SwitchListTile(
              value: _vegetaraianFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _vegetaraianFilterSet = isChecked;
                });
              },
              title: Text(
                'Vegetarian', // Fixed spelling mistake
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              subtitle: Text(
                'Only Include Vegetarian Meals', // Fixed spelling mistake
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              activeColor: Colors.green,
              contentPadding: EdgeInsets.only(left: 34, right: 22),
            ),

            // Switch to enable or disable Non-Vegetarian filter
            SwitchListTile(
              value: _nonVegFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _nonVegFilterSet = isChecked;
                });
              },
              title: Text(
                'Non-Vegetarian', // Fixed spelling mistake
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              subtitle: Text(
                'Only Include Non-Vegetarian Meals', // Fixed spelling mistake
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              activeColor: Colors.green,
              contentPadding: EdgeInsets.only(left: 34, right: 22),
            ),
          ],
        ),
      ),
    );
  }
}
