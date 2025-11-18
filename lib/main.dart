import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/doctor_near_me_screen.dart';
import 'screens/ai_chat_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clinico',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const SplashScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/ai_chat': (context) => const AiChatScreen(),
        '/appointment_search': (context) => const DoctorNearMeScreen(),
        '/appointment_search/location': (context) => const DoctorNearMeScreen(),
      },
    );
  }
}
