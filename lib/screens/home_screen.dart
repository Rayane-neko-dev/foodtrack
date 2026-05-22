import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/food_store.dart';
import '../models/food_item.dart';
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

  void _openItem(FoodItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => ItemDetailSheet(item: item),
    );
  }

  Widget _buildSection(
    String title,
    List<FoodItem> items,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        if (items.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "No items",
              style: TextStyle(color: Colors.grey),
            ),
          ),

        if (items.isNotEmpty)
          SizedBox(
            height: 170,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {

                final item = items[index];

                return GestureDetector(
                  onTap: () => _openItem(item),

                  child: Container(
                    width: 130,
                    margin: const EdgeInsets.only(right: 14),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 8,
                        ),
                      ],
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(18),
                            ),

                            child: item.imageUrl != null
                                ? Image.file(
                                    File(item.imageUrl!),
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    color: Colors.green.shade100,
                                    child: const Center(
                                      child: Icon(
                                        Icons.fastfood,
                                        size: 40,
                                      ),
                                    ),
                                  ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(10),

                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [

                              Text(
                                item.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                "Qty: ${item.quantity}",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),

                              const SizedBox(height: 2),

                              Text(
                                item.expiryLabel,
                                style: TextStyle(
                                  fontSize: 12,
                                  color:
                                      item.daysUntilExpiry <= 3
                                          ? Colors.red
                                          : Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

        const SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    final store = context.watch<FoodStore>();

    return Scaffold(

      appBar: AppBar(
        title: const Text("FoodTrack"),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddItemScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [

            const SizedBox(height: 10),

            _buildSection(
              " Expiring Soon",
              store.expiringSoon,
            ),

            _buildSection(
              " Next Week",
              store.nextWeek,
            ),

            _buildSection(
              " Good For Now",
              store.goodForNow,
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}