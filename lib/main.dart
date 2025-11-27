import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/audio_call_screen.dart';
import 'screens/in_audio_call_screen.dart';

void main() {
 runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clinico - Healthcare Management System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/audio_call': (context) => const AudioCallScreen(),
        '/in_audio_call': (context) => const InAudioCallScreen(),
      },
    );
  }
}