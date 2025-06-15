import 'package:flutter/material.dart';
import 'package:meals_app/modals/meal.dart';
import 'package:meals_app/widgets/meals_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal,required this.onSelectMeal});
  final Meal meal;
  final void Function (Meal meal)onSelectMeal;

  @override
  Widget build(BuildContext context) {
    String complexitytext() {
      //only first word capital
      return meal.complexity.name[0].toUpperCase() +
          meal.complexity.name.substring(1);
      //return meal.complexity.name.substring(0).toUpperCase();--> full string uppercase
    }

    String affordabilityText() {
      return meal.affordability.name[0].toUpperCase() +
          meal.affordability.name.substring(1);
    }

    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: (){
         onSelectMeal(meal);
        },
        child: Stack(
          children: [
            FadeInImage(
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 44,
                ),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6,),
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealsItemTrait(
                          icon: Icons.schedule,
                          label: '${meal.duration}min',
                        ),
                        const SizedBox(width: 12),
                        MealsItemTrait(
                          icon: Icons.work,
                          label: complexitytext(),
                        ),
                        const SizedBox(width: 12),
                        MealsItemTrait(
                          icon: Icons.attach_money_rounded,
                          label: affordabilityText(),
                        ),
                      ],
                    ),
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
