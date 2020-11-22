import 'package:flutter/material.dart';
import 'package:meal_ss/models/meal.dart';
import 'package:meal_ss/screens/categories_screen.dart';
import 'package:meal_ss/screens/favourites_screen.dart';
import 'package:meal_ss/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  List<Meal> favourites;

  TabsScreen(this.favourites);
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _page;
  int _selectedIndex = 0;

  @override
  void initState() {
    _page = [
      {
        'Page': CategoriesScreen(),
        'title': 'Categories',
      },
      {
        'Page': Favourites(widget.favourites),
        'title': 'Your Favourites',
      }
    ]; // TODO: implement initState
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_page[_selectedIndex]['title']),
      ),
      drawer: MainDrawer(),
      body: _page[_selectedIndex]['Page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedIndex,
        // type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            title: Text(
              'Categories',
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.favorite),
            title: Text(
              'Favourites',
            ),
          ),
        ],
      ),
    );
  }
}
