import 'package:flutter/material.dart';
import 'package:clinico/screens/language_screen.dart';
import '../constants/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLanguageScreen();
  }

  void _navigateToLanguageScreen() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LanguageScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.b1, AppColors.b5],
          ),
        ),
        child: Stack(
          children: [
            // Particles background overlay
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/splash_screen/particals.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Logo (positioned at top-center)
            Positioned(
              left: 0,
              right: 0,
              top: 30,
              child: Center(
                child: Container(
                  width: 85,
                  height: 85,
                  decoration: BoxDecoration(
                    color: Colors.white, // White background of exact logo size
                    image: DecorationImage(
                      image: AssetImage("assets/splash_screen/logo.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            // App name "CLINICO"
            Positioned(
              left: 0,
              right: 0,
              top: 125,
              child: Center(
                child: Text(
                  'CLINICO',
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 32,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w800,
                    height: 1.0,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
            ),
            // Mascot container (circular background)
            Positioned(
              left: 0,
              right: 0,
              top: 240,
              child: Center(
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: ShapeDecoration(
                    color: AppColors.white.withOpacity(0.1),
                    shape: const OvalBorder(),
                  ),
                ),
              ),
            ),
            // Mascot image
            Positioned(
              left: 0,
              right: 0,
              top: 180,
              child: Center(
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/splash_screen/mascot.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            // Tagline "The Healing Hand Initiative"
            Positioned(
              left: 20,
              right: 20,
              bottom: 100,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'The Healing Hand Initiative',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 26,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Green strip highlight under tagline
                  Container(
                    width: 200,
                    height: 25,
                    decoration: BoxDecoration(
                      color: AppColors.g1, // Changed to use the official color
                    ),
                  ),
                ],
              ),
            ),
            // Copyright footer
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: Center(
                child: Text(
                  '© 2025 Clinico. All rights reserved.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 12,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    height: 1.45,
                    letterSpacing: 0.50,
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
