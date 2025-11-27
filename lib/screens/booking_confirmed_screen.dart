import 'package:flutter/material.dart';
import '../screens/home_screen.dart';

class BookingConfirmedScreen extends StatelessWidget {
  final String doctorName;
  final String appointmentDate;
  final String appointmentTime;

  const BookingConfirmedScreen({
    Key? key,
    required this.doctorName,
    required this.appointmentDate,
    required this.appointmentTime,
  }) : super(key: key);

  @override
 Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Status Bar (Time, Signal, WiFi, Battery)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '9:41',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.signal_cellular_alt, color: Colors.black),
                      SizedBox(width: 4),
                      Icon(Icons.wifi, color: Colors.black),
                      SizedBox(width: 4),
                      Icon(Icons.battery_full, color: Colors.black),
                    ],
                  ),
                ],
              ),
            ),
            
            // Success Illustration (centered at the top)
            Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: Image.asset(
                'assets/booking_confirmed.png',
                width: 100,
                height: 100,
              ),
            ),
            
            // Main Heading
            Padding(
              padding: EdgeInsets.only(top: 32.0),
              child: Text(
                'Booking Confirmed',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E3A8A), // Dark blue color
                ),
              ),
            ),
            
            // Sub-heading
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                'Your Booking has been confirmed.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ),
            
            // Dynamic Appointment Text (center of screen)
            Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: Column(
                children: [
                  Text(
                    'You Have an appointment with ',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Dr. $doctorName',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.black87, // Changed to black instead of dark blue
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'on $appointmentDate at $appointmentTime.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.black87, // Changed to black instead of dark blue
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            
            Spacer(), // Pushes the button to the bottom
            
            // Action Button (pinned to bottom)
            Padding(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Navigate back to home screen and clear the back stack
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    (route) => false, // This removes all previous routes
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3B82F6), // Primary blue
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(
                  'Back to home',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            
            // Home Indicator
            Container(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Container(
                width: 134,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ],
        ),
      ),
    );
 }
}