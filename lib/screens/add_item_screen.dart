import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../models/food_item.dart';
import '../providers/food_store.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _nameCtrl = TextEditingController();

  final picker = ImagePicker();
  XFile? image;

  int quantity = 1;

  DateTime purchaseDate = DateTime.now();
  DateTime expiryDate = DateTime.now().add(const Duration(days: 7));

  String category = "General";
  String location = "Fridge";

  final fmt = DateFormat('dd/MM/yyyy');

  final List<String> categories = [
    "Fruits",
    "Vegetables",
    "Dairy",
    "Meat",
    "Pasta",
    "General",
  ];

  final List<String> locations = [
    "Fridge",
    "Freezer",
    "Pantry",
    "Counter",
  ];

  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      setState(() => image = picked);
    }
  }

  Future<void> pickDate(bool isExpiry) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isExpiry ? expiryDate : purchaseDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );

    if (picked != null) {
      setState(() {
        if (isExpiry) {
          expiryDate = picked;
        } else {
          purchaseDate = picked;
        }
      });
    }
  }

  void _inc() => setState(() => quantity++);
  void _dec() {
    if (quantity > 1) setState(() => quantity--);
  }

  void _save() {
    if (_nameCtrl.text.trim().isEmpty) return;

    final item = FoodItem(
      id: const Uuid().v4(),
      name: _nameCtrl.text.trim(),
      category: category,
      location: location,
      expiryDate: expiryDate,
      purchaseDate: purchaseDate,
      quantity: quantity,
      imageUrl: image?.path,
    );

    context.read<FoodStore>().addItem(item);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Item"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // IMAGE
            GestureDetector(
              onTap: pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage:
                    image != null ? FileImage(File(image!.path)) : null,
                child: image == null
                    ? const Icon(Icons.camera_alt, color: Colors.white)
                    : null,
              ),
            ),

            const SizedBox(height: 20),

            // NAME
            TextField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: "Name"),
            ),

            const SizedBox(height: 10),

            // CATEGORY
            DropdownButtonFormField(
              value: category,
              items: categories
                  .map((c) => DropdownMenuItem(
                        value: c,
                        child: Text(c),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => category = v!),
              decoration: const InputDecoration(labelText: "Category"),
            ),

            const SizedBox(height: 10),

            // LOCATION
            DropdownButtonFormField(
              value: location,
              items: locations
                  .map((l) => DropdownMenuItem(
                        value: l,
                        child: Text(l),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => location = v!),
              decoration: const InputDecoration(labelText: "Location"),
            ),

            const SizedBox(height: 20),

            // QUANTITY
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _dec,
                  icon: const Icon(Icons.remove_circle_outline),
                  color: Colors.green,
                ),
                Text(
                  "$quantity",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: _inc,
                  icon: const Icon(Icons.add_circle_outline),
                  color: Colors.green,
                ),
              ],
            ),

            const SizedBox(height: 10),

            // DATES
            ListTile(
              title: Text("Purchase: ${fmt.format(purchaseDate)}"),
              trailing: const Icon(Icons.date_range),
              onTap: () => pickDate(false),
            ),

            ListTile(
              title: Text("Expiry: ${fmt.format(expiryDate)}"),
              trailing: const Icon(Icons.date_range),
              onTap: () => pickDate(true),
            ),

            const SizedBox(height: 20),

            // SAVE
SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    onPressed: _save,
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.green, //
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    child: const Text(
      "Save Item",
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),
          ],
        ),
      ),
    );
  }
}