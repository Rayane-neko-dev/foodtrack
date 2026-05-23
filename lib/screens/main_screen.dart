import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'inventory_screen.dart';
import 'categories_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _index = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    InventoryScreen(),
    CategoriesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,

        onTap: (i) {
          setState(() {
            _index = i;
          });
        },

        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2),
            label: "Inventory",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.kitchen),
            label: "Storage",
          ),
        ],
      ),
    );
  }
}