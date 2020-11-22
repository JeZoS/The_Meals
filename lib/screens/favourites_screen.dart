import 'package:flutter/material.dart';
import 'package:meal_ss/models/meal.dart';
import '../widgets/meal_item.dart';

class Favourites extends StatelessWidget {
  final List<Meal> favs;

  Favourites(this.favs);

  @override
  Widget build(BuildContext context) {
    if (favs.isEmpty) {
      return Container(
        child: Center(
          child: Text('Add meals to favourites'),
        ),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favs[index].id,
            title: favs[index].title,
            imageUrl: favs[index].imageUrl,
            duration: favs[index].duration,
            complexity: favs[index].complexity,
            affordability: favs[index].affordability,
            removeItem: null, //_removeMeal,
          );
        },
        itemCount: favs.length,
      );
    }
  }
}
