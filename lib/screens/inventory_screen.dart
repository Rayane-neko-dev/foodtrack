import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/food_store.dart';
import '../models/food_item.dart';
import '../widgets/food_card';
import '../widgets/item_detail_sheet.dart';

class InventoryScreen extends StatefulWidget {
  final String? filter; // from Storage screen

  const InventoryScreen({super.key, this.filter});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  String _query = "";

  void _open(BuildContext context, FoodItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ItemDetailSheet(item: item),
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<FoodStore>();

    // 📦 FILTER by storage location + search
    final items = store.items.where((item) {
      final matchLocation =
          widget.filter == null || item.location == widget.filter;

      final matchSearch =
          item.name.toLowerCase().contains(_query.toLowerCase());

      return matchLocation && matchSearch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.filter == null
              ? "Inventory"
              : "Storage: ${widget.filter}",
        ),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),

      body: Column(
        children: [
          // 🔍 SEARCH BAR
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: TextField(
                onChanged: (value) => setState(() => _query = value),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.green),
                  hintText: "Search items...",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(12),
                ),
              ),
            ),
          ),

          // 📦 GRID
          Expanded(
            child: items.isEmpty
                ? const Center(child: Text("No items found"))
                : GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: items.length,
                    itemBuilder: (_, i) {
                      final item = items[i];
                      return FoodCard(
                        item: item,
                        onTap: () => _open(context, item),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}