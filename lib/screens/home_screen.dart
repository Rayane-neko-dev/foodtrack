import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/food_store.dart';
import '../models/food_item.dart';
import '../widgets/food_card';
import '../widgets/item_detail_sheet.dart';
import 'add_item_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<FoodStore>().load();
    });
  }

  void _openItem(BuildContext context, FoodItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ItemDetailSheet(item: item),
    );
  }

  Widget _buildSection(String title, List<FoodItem> items) {
    if (items.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (_, i) {
              final item = items[i];
              return FoodCard(
                item: item,
                onTap: () => _openItem(context, item),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<FoodStore>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: const Text("FoodTrack"),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddItemScreen()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),

      body: store.items.isEmpty
          ? const Center(child: Text("No food yet\nAdd your groceries"))
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),

                  _buildSection("Expiring soon", store.expiringSoon),
                  _buildSection("Next week", store.nextWeek),
                  _buildSection("Good for now", store.goodForNow),

                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }
}