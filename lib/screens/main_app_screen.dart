import 'package:flutter/material.dart';
import 'home_screen.dart';
import '../pages/user_profile_page.dart';

class MainAppScreen extends StatefulWidget {
  @override
  _MainAppScreenState createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int _currentIndex = 0;
  List<Widget> get _children => [
    HomeScreen(), // Home
    _buildPlaceholderScreen('Messages', Colors.blue), // Messages placeholder - would implement actual messages screen
    _buildPlaceholderScreen('Appointments', Colors.green), // Appointments placeholder - would implement actual appointments screen
    UserProfilePage(), // Profile
  ];

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF174880), // b1
        unselectedItemColor: Color(0xFF6A7282), // ge3
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/home/home_filled.png',
              width: 24,
              height: 24,
              color: _currentIndex == 0
                  ? Color(0xFF174880) // b1
                  : Color(0xFF6A7282), // ge3
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/home/messages.png',
              width: 24,
              height: 24,
              color: _currentIndex == 1
                  ? Color(0xFF174880) // b1
                  : Color(0xFF6A7282), // ge3
            ),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/home/calender.png',
              width: 24,
              height: 24,
              color: _currentIndex == 2
                  ? Color(0xFF174880) // b1
                  : Color(0xFF6A7282), // ge3
            ),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/home/profile.png',
              width: 24,
              height: 24,
              color: _currentIndex == 3
                  ? Color(0xFF174880) // b1
                  : Color(0xFF6A7282), // ge3
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderScreen(String title, Color color) {
    return Scaffold(
      backgroundColor: Color(0xFFEBF1FA), // bg1
      body: SafeArea(
        child: Center(
          child: Text(
            '$title Screen\n(To be implemented)',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[700],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}