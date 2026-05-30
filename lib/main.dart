import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'providers/food_store.dart';
import 'screens/main_screen.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  final seenSplash = prefs.getBool("seenSplash") ?? false;

  runApp(
    FoodTrackApp(
      seenSplash: seenSplash,
    ),
  );
}

class FoodTrackApp extends StatelessWidget {
  final bool seenSplash;

  const FoodTrackApp({
    super.key,
    required this.seenSplash,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FoodStore(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FoodTrack',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),

        home: seenSplash
            ? const MainScreen()
            : const SplashScreen(),
      ),
    );
  }
}