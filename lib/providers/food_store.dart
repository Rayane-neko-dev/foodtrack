import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/food_item.dart';

class FoodStore extends ChangeNotifier {

  static const String _storageKey = 'food_items';

  List<FoodItem> _items = [];

  List<FoodItem> get items => _items;

  // =========================
  // HOME SCREEN SECTIONS
  // =========================

  List<FoodItem> get expiringSoon {
    return _items.where((item) {
      return item.daysUntilExpiry <= 3;
    }).toList();
  }

  List<FoodItem> get nextWeek {
    return _items.where((item) {
      return item.daysUntilExpiry > 3 &&
          item.daysUntilExpiry <= 7;
    }).toList();
  }

  List<FoodItem> get goodForNow {
    return _items.where((item) {
      return item.daysUntilExpiry > 7;
    }).toList();
  }

  // =========================
  // LOAD DATA
  // =========================

  Future<void> load() async {

    final prefs =
        await SharedPreferences.getInstance();

    final raw =
        prefs.getString(_storageKey);

    if (raw != null) {
      _items = FoodItem.decodeList(raw);
    }

    notifyListeners();
  }

  // =========================
  // SAVE DATA
  // =========================

  Future<void> _save() async {

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setString(
      _storageKey,
      FoodItem.encodeList(_items),
    );
  }

  // =========================
  // ADD ITEM
  // =========================

  Future<void> addItem(FoodItem item) async {

    _items.add(item);

    await _save();

    notifyListeners();
  }

  // =========================
  // REMOVE ITEM
  // =========================

  Future<void> removeItem(String id) async {

    _items.removeWhere(
      (item) => item.id == id,
    );

    await _save();

    notifyListeners();
  }

  // =========================
  // UPDATE QUANTITY
  // =========================

  Future<void> updateQuantity(
    String id,
    int change,
  ) async {

    final index = _items.indexWhere(
      (item) => item.id == id,
    );

    if (index == -1) return;

    _items[index].quantity += change;

    if (_items[index].quantity < 1) {
      _items[index].quantity = 1;
    }

    await _save();

    notifyListeners();
  }
}