import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/modals/meal.dart';
import 'package:meals_app/screens/categories_screens.dart';
import 'package:meals_app/screens/filter_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import 'package:meals_app/providers/meals_provider.dart';

const kInitialFilters ={
    Filters.glutenFree:false,
    Filters.lactoseFree:false,
    Filters.vegetarian:false,
    Filters.vegan:false,

  };
class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends ConsumerState<TabScreen> {

   Map <Filters,bool>_selectedFilters =kInitialFilters;

  int _selectpageIndex = 0;
  //logic for fav. meals
  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
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

  void _onScreen(String identifier) async{

   
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result =await Navigator.of(
        context,
      ).push<Map<Filters,bool>>(MaterialPageRoute(builder: (context) =>  FilterScreen(currentFilters: _selectedFilters,)));
      setState(() {
        _selectedFilters= result ?? kInitialFilters;
      });
      
    }     
  }

  @override
  Widget build(BuildContext context) {
    final meals =ref.watch(mealsProvider);

     final availableMeals =meals.where((meal){
      if(_selectedFilters[Filters.glutenFree]! && !meal.isGlutenFree){
        return false;
      }
      if(_selectedFilters[Filters.lactoseFree]! && !meal.isLactoseFree){
        return false;
      }
      if(_selectedFilters[Filters.vegetarian]! && !meal.isVegetarian){
        return false;
      }
      if(_selectedFilters[Filters.vegan]! && !meal.isVegan){
        return false;
      }
      return true;
    },).toList();
    Widget activePage = CategoriesScreens(selectedFav: _toggleMealsFavorites,availableMeals: availableMeals,);
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
      drawer: MainDrawer(onSelectScreen: _onScreen),
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
