import 'package:flutter/material.dart';
/* import 'package:meals_app/screens/tab_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart'; */

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegetarianFilterSet = false;
  var _veganFreeFilterSet = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Filters")),
      /* drawer: MainDrawer(
        onSelectScreen: (identifier) {
          Navigator.of(context).pop();
          if (identifier == 'meals') {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => const TabScreen()));
          }
        },
      ), */
      body: Column(
        children: [
          //gluten free switch 
          SwitchListTile(
            value: _glutenFreeFilterSet,
            onChanged: (value) {
              setState(() {
                _glutenFreeFilterSet = value;
              });
            },
            title: Text(
              "Gluten-Free",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            subtitle: Text(
              "Only includes gluten-free meals",
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          //lactose free switch 
          SwitchListTile(
            value: _lactoseFreeFilterSet,
            onChanged: (value) {
              setState(() {
                _lactoseFreeFilterSet = value;
              });
            },
            title: Text(
              "Lactose-Free",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            subtitle: Text(
              "Only includes lactose-free meals",
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          //vegetarian switch 
          SwitchListTile(
            value: _vegetarianFilterSet,
            onChanged: (value) {
              setState(() {
                _vegetarianFilterSet = value;
              });
            },
            title: Text(
              "Vegetarian",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            subtitle: Text(
              "Only includes vegetarian meals",
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          //vegan switch
          SwitchListTile(
            value: _veganFreeFilterSet,
            onChanged: (value) {
              setState(() {
                _veganFreeFilterSet = value;
              });
            },
            title: Text(
              "Vegan",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            subtitle: Text(
              "Only includes vegan meals",
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
        ],
      ),
    );
  }
}
