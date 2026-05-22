import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/food_store.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const FoodTrackApp());
}

class FoodTrackApp extends StatelessWidget {
  const FoodTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FoodStore()..load(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FoodTrack',
        home: const MainScreen(),
      ),
    );
  }
}