import 'package:flutter/material.dart';
import 'package:clinico/screens/onboarding2_screen.dart';
import '../constants/colors.dart';

class Onboarding1Screen extends StatelessWidget {
  const Onboarding1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.bg1,
        child: Column(
          children: [
            // Top padding
            const SizedBox(height: 40),
            
            // Feature Illustration - Large image with background
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.g2,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset(
                  'assets/onboarding/feature1.png',
                  height: 380,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Title and subtitle section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title with green underline
                  Stack(
                    children: [
                      Text(
                        'Chat with Elphie our AI Care Companion',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: AppColors.ge1,
                          height: 1.3,
                        ),
                      ),
                      // Green strip underline positioned under "Elphie our AI Care"
                      Positioned(
                        top: 32,
                        left: 0,
                        child: Container(
                          width: 180,
                          height: 6,
                          decoration: BoxDecoration(
                            color: AppColors.g1,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Subtitle
                  const Text(
                    'Get instant, intelligent health advice anytime, and anywhere.',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.ge2,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            
            const Spacer(),
            
            // Progress Indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Step 1 - Active
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: AppColors.b1,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        '1',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Connecting line
                  Container(
                    width: 30,
                    height: 2,
                    color: AppColors.b4,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                  // Step 2 - Inactive
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: AppColors.b3,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        '2',
                        style: TextStyle(
                          color: AppColors.ge2,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Connecting line
                  Container(
                    width: 30,
                    height: 2,
                    color: AppColors.b3,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                  // Step 3 - Inactive
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: AppColors.b3,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        '3',
                        style: TextStyle(
                          color: AppColors.ge2,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Next Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const Onboarding2Screen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.b4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
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
