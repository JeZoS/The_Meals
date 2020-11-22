import 'package:flutter/material.dart';
import 'package:meal_ss/dummy_data.dart';
import 'package:meal_ss/models/meal.dart';
import 'package:meal_ss/screens/categories_screen.dart';
import 'package:meal_ss/screens/category_meal_screen.dart';
import 'package:meal_ss/screens/filter_screen.dart';
import 'package:meal_ss/screens/meal_detail_screen.dart';
import 'package:meal_ss/screens/tabs_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favourites = [];

  bool _isMealFav(String id) {
    return _favourites.any((element) => element.id == id);
  }

  void toggleFavourites(String mealid) {
    final exindex = _favourites.indexWhere((element) => mealid == element.id);
    if (exindex >= 0) {
      setState(() {
        _favourites.removeAt(exindex);
      });
    } else {
      setState(() {
        _favourites
            .add(DUMMY_MEALS.firstWhere((element) => element.id == mealid));
      });
    }
  }

  Map<String, bool> _filters = {
    'gluten': false,
    'vegetarian': false,
    'vegan': false,
    'lactose': false,
  };
  void _setFilter(Map<String, bool> filterdata) {
    setState(() {
      _filters = filterdata;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Meals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              body2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              title: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      //home: CategoriesScreen(),
      routes: {
        '/': (ctx) => TabsScreen(_favourites),
        '/categories-meals': (ctx) => CategoryMealScreen(_availableMeals),
        MealDetails.routeName: (ctx) =>
            MealDetails(toggleFavourites, _isMealFav),
        '/filter_screen': (ctx) => FilterScreen(_setFilter, _filters),
      },
    );
  }
}
