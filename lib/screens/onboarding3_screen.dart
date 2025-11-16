import 'package:flutter/material.dart';
import 'package:clinico/screens/login_screen.dart';

class Onboarding3Screen extends StatelessWidget {
  const Onboarding3Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFF5F7FA),
        child: Column(
          children: [
            // Top padding
            const SizedBox(height: 40),
            
            // Feature Illustration - Large image without background card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Image.asset(
                'assets/onboarding/feature3.png',
                height: 380,
                fit: BoxFit.contain,
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
                      const Text(
                        'Video Consultations',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF333333),
                          height: 1.3,
                        ),
                      ),
                      // Green strip underline positioned under entire title
                      Positioned(
                        top: 30,
                        left: 0,
                        child: Container(
                          width: 220,
                          height: 8,
                          decoration: BoxDecoration(
                            color: const Color(0xFF7CB342),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Subtitle
                  const Text(
                    'Connect with doctors virtually, anytime, and anywhere. Your health, on your schedule.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
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
                  // Step 1 - Completed with checkmark
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Color(0xFF7CB342),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  // Connecting line
                  Container(
                    width: 30,
                    height: 2,
                    color: const Color(0xFF4A85DD),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                  // Step 2 - Completed with checkmark
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Color(0xFF7CB342),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  // Connecting line
                  Container(
                    width: 30,
                    height: 2,
                    color: const Color(0xFF4A85DD),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                  // Step 3 - Active
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Color(0xFF003261),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        '3',
                        style: TextStyle(
                          color: Colors.white,
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
            
            // Get Started Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A85DD),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
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
