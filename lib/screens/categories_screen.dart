import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/food_store.dart';
import 'inventory_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.watch<FoodStore>();

    final locations = store.items
        .map((e) => e.location)
        .toSet()
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Storage"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),

      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: locations.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          final location = locations[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => InventoryScreen(filter: location),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.green),
              ),
              child: Center(
                child: Text(
                  location,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}