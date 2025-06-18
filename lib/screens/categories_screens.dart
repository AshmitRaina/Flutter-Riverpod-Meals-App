import 'package:flutter/material.dart';

import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/modals/meal.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/category_grid_item.dart';
import 'package:meals_app/modals/category.dart';

class CategoriesScreens extends StatelessWidget {
  const CategoriesScreens({super.key,required this.selectedFav,required this. availableMeals});
  final List<Meal> availableMeals;
  final void Function(Meal meal) selectedFav;
  void _selectCategory(BuildContext context, Category category) {
    final filteredList = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    // Navigator.push(context, route)==> one method
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealsScreen(title: category.title, meals: filteredList,selectedFav: selectedFav,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 3 / 2,
          crossAxisCount: 2,
        ),
        //firstly i want the dummy data to be traversed.
        children: [
          //you cann also do it using the map -->
          //...availableCategories.map((category)=>CategoryGridItem(category:category)),
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context,category);
              },
            ),
        ],
      );
  }
}
