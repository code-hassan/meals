import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/meal.dart';
import 'meal_item_trait.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.onSelectedMeal});
  final Meal meal;
  final void Function(BuildContext context , Meal meal) onSelectedMeal;
  String get complexityText{
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }
  String get affordabilityText{
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: (){
          onSelectedMeal(context,meal);
        },
        child: Stack(
          children: [
            Hero(
              tag: meal.id,
              child: FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            Positioned(
               left: 0,
              right: 0,
              bottom: 0,
                child: Container(
                  color: Colors.black54,
                  padding: const EdgeInsets.symmetric(horizontal: 44,vertical: 6),
                  child: Column(
                    children: [
                     Text(
                       meal.title,
                       maxLines: 2,
                       textAlign: TextAlign.center,
                       softWrap: true,
                       overflow: TextOverflow.ellipsis,
                       style: const TextStyle(
                         fontSize: 20,
                         fontWeight: FontWeight.bold,
                         color: Colors.white,
                       ),
                     ),
                      const SizedBox(height: 12,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                        MealItemTraits(
                            iconData: Icons.schedule,
                            label: "${meal.duration} min",
                        ),
                         const SizedBox(width: 12,),
                        MealItemTraits(
                          iconData: Icons.work,
                          label: complexityText,
                        ),
                          const SizedBox(width: 12,),
                        MealItemTraits(
                          iconData: Icons.money,
                          label: affordabilityText,
                        ),


                      ],),
                    ],
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
