import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/splash_screen.dart';
import 'screens/audio_call_screen.dart';
import 'screens/in_audio_call_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF4A85DD), // Set status bar color to match our theme
      statusBarIconBrightness: Brightness.dark, // For light status bar icons
      statusBarBrightness: Brightness.light, // For light status bar on Android
    ),
  );
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