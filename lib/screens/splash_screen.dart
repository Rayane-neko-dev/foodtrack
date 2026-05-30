import 'package:flutter/material.dart';
import '../models/app_theme.dart';
import 'main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundGreen,
      body: SafeArea(
        child: Column(
          children: [
            // TOP DECORATION
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 160,
                  width: double.infinity,
                  color: AppTheme.backgroundGreen,
                ),

                Positioned(
                  top: -40,
                  left: -40,
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.primaryGreen.withOpacity(0.35),
                    ),
                  ),
                ),

                Positioned(
                  top: 20,
                  left: 90,
                  child: Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.accentGreen.withOpacity(0.25),
                    ),
                  ),
                ),
              ],
            ),

            const Spacer(),

            // SVG ILLUSTRATION
            SizedBox(
              width: 260,
              height: 260,
              child: SvgPicture.asset(
                'assets/images/undraw_online-groceries_n03y.svg',
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 40),

            const Text(
              'no more waste with Food Track',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppTheme.textDark,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'keep track of your groceries\nget notified before they turn bad',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppTheme.textGrey,
                fontSize: 15,
              ),
            ),

            const Spacer(),

            // BUTTON
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool("seenSplash", true);

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => const MainScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF608F20),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Get started',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}