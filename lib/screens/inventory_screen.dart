import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/food_store.dart';
import '../widgets/food_card';
import '../widgets/item_detail_sheet.dart';
import '../models/food_item.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  void _open(BuildContext context, FoodItem item) {
    showModalBottomSheet(
      context: context,
      builder: (_) => ItemDetailSheet(item: item),
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<FoodStore>();

    return Scaffold(
      appBar: AppBar(title: const Text("Inventory")),

      body: store.items.isEmpty
          ? const Center(child: Text("No items"))
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: store.items.length,
              itemBuilder: (_, i) {
                final item = store.items[i];
                return FoodCard(
                  item: item,
                  onTap: () => _open(context, item),
                );
              },
            ),
    );
  }
}