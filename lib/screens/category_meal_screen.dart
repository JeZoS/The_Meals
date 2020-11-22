import 'package:flutter/material.dart';
import 'package:meal_ss/dummy_data.dart';
import 'package:meal_ss/models/meal.dart';
import 'package:meal_ss/widgets/meal_item.dart';

class CategoryMealScreen extends StatefulWidget {
  final List<Meal> availableMeals;

  CategoryMealScreen(this.availableMeals);
  // final String categoryTitle;
  // final String categoryId;
  // displayedMealscreen(this.categoryTitle, this.categoryId);

  @override
  _CategoryMealScreenState createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;
  var _loadedInitData = false;

  void _removeMeal(String id) {
    setState(() {
      displayedMeals.removeWhere((element) => element.id == id);
    });
  }

  @override
  void initState() {
    // final routeArgs =
    //     ModalRoute.of(context).settings.arguments as Map<String, String>;
    // categoryTitle = routeArgs['title'];
    // final categoryId = routeArgs['id'];
    // displayedMeals = DUMMY_MEALS
    //     .where((element) => element.categories.contains(categoryId))
    //     .toList();
    super.initState();
  }

  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      displayedMeals = widget.availableMeals
          .where((element) => element.categories.contains(categoryId))
          .toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            imageUrl: displayedMeals[index].imageUrl,
            duration: displayedMeals[index].duration,
            complexity: displayedMeals[index].complexity,
            affordability: displayedMeals[index].affordability,
            removeItem: _removeMeal,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
