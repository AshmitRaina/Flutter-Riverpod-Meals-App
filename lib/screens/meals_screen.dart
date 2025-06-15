import 'package:flutter/material.dart';

import 'package:meals_app/modals/meal.dart';
import 'package:meals_app/screens/meals_details_screen.dart';
import 'package:meals_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key,  this.title, required this.meals,required this.selectedFav});
  // I want the title that was selected
  final String? title;
  // I want all its properties be displayed below it
  final List<Meal> meals;
  final void Function(Meal meal) selectedFav;
  void selectmeals(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => MealsDetailsScreen(meal: meal,selectedFav:  selectedFav,)),
    );
  }

  @override
  Widget build(BuildContext context) {
    //there are cases where meals are empty
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "OH OO .... NOTHING HERE!!",
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Try selecting a different category !!",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) => MealItem(meal: meals[index],onSelectMeal: (meal){
          selectmeals(context,meal);
        },),
      );
    }
    if (title==null){
      return content;
    }
    return Scaffold(
      appBar: AppBar(title: Text(title!)),
      body: content,
    );
  }
}
