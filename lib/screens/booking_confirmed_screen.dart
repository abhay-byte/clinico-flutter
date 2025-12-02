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
      backgroundColor: Color(
        0xFFF6F8FB,
      ), // Set background color to #F6F8FB to extend behind status bar
      body: SafeArea(
        top: true, // Respect top safe area
        bottom: false, // We'll handle bottom padding manually
        child: Container(
          color: Color(
            0xFFF6F8FB,
          ), // Background color extends behind status bar
          child: Column(
            children: [
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
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ),

              // Dynamic Appointment Text (center of screen) with more horizontal padding
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
                child: Column(
                  children: [
                    Text(
                      'You Have an appointment with ',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Dr. $doctorName',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors
                            .black87, // Changed to black instead of dark blue
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
                        color: Colors
                            .black87, // Changed to black instead of dark blue
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              Spacer(), // Pushes the button to the bottom
              // Action Button (pinned to bottom) with proper bottom padding for safe area
              Container(
                padding: EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: 30.0,
                ), // Added 30px bottom padding
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
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              // Add safe area padding at the bottom to avoid home indicator
              SafeArea(
                top: false,
                bottom: true,
                child: Container(
                  height:
                      0, // Minimal container just to respect bottom safe area
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
