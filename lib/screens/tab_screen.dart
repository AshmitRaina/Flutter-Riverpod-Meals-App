import 'package:flutter/material.dart';
import 'package:meals_app/modals/meal.dart';
import 'package:meals_app/screens/categories_screens.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectpageIndex = 0;
  //logic for fav. meals
  void showSnackbar(String message ){
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
  final List<Meal> favoriteMeals = [];
  void _toggleMealsFavorites(Meal meal) {
    var isExisting = favoriteMeals.contains(meal);
    if (isExisting) {
      setState(() {
        favoriteMeals.remove(meal);
      });
      showSnackbar("Meal removed from Favorites.");
    } else {
      setState(() {
        favoriteMeals.add(meal);
      });
       showSnackbar("Meal added to Favorites.");
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectpageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreens(selectedFav: _toggleMealsFavorites);
    var activePageTitle = "Categories";
    if (_selectpageIndex == 1) {
      activePageTitle = "Your Favorites";
      activePage = MealsScreen(
        meals: favoriteMeals,
        selectedFav: _toggleMealsFavorites,
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      body: activePage,
      drawer: const MainDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectpageIndex,
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: "Category",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites"),
        ],
      ),
    );
  }
}
