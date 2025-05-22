import 'package:flutter/material.dart';
import 'package:recipe_explorer_pro/feature/categories/categories_screen.dart';
import 'package:recipe_explorer_pro/feature/favorite/favorite_screen.dart';
import 'package:recipe_explorer_pro/feature/home/home_screen.dart';
import 'package:recipe_explorer_pro/feature/map/map_view_page.dart';
import 'package:recipe_explorer_pro/feature/my_recipe/my_recipe_screen.dart';
import 'feature/profile/profile_screen.dart'; // создадим позже

class MainNavigation extends StatefulWidget {
  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    MyRecipeScreen(),
    FavoriteScreen(),
    MapViewPage(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
