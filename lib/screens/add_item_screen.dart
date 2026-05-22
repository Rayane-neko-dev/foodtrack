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
  final _qtyCtrl = TextEditingController(text: "1");

  final picker = ImagePicker();
  XFile? image;

  DateTime purchaseDate = DateTime.now();
  DateTime expiryDate = DateTime.now().add(const Duration(days: 7));

  final fmt = DateFormat('dd/MM/yyyy');

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

  void _save() {
    if (_nameCtrl.text.trim().isEmpty) return;

    final item = FoodItem(
      id: const Uuid().v4(),
      name: _nameCtrl.text.trim(),
      category: "General",
      location: "Fridge",
      quantity: int.tryParse(_qtyCtrl.text) ?? 1,
      purchaseDate: purchaseDate,
      expiryDate: expiryDate,
      imageUrl: image?.path,
    );

    context.read<FoodStore>().addItem(item);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Item")),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            GestureDetector(
              onTap: pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage:
                    image != null ? FileImage(File(image!.path)) : null,
                child: image == null
                    ? const Icon(Icons.camera_alt)
                    : null,
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: "Name"),
            ),

            TextField(
              controller: _qtyCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Quantity"),
            ),

            const SizedBox(height: 10),

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

            ElevatedButton(
              onPressed: _save,
              child: const Text("Save Item"),
            ),
          ],
        ),
      ),
    );
  }
}