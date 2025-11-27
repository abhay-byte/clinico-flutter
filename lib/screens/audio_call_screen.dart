/// Audio Call Screen
///
/// This screen is the Incoming Appointment Call Screen, which is displayed when
/// the doctor initiates the scheduled virtual consultation with the patient.
/// It functions like a standard mobile call screen, but is themed to the healthcare application.
///
/// The purpose of this screen is to clearly notify the user of the incoming call,
/// identify the medical professional, and provide immediate, large controls to either
/// accept or decline the consultation.
library;
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'in_audio_call_screen.dart';

class AudioCallScreen extends StatefulWidget {
  final String doctorName;
  final String doctorSpecialization;
  final String appointmentTime;

  const AudioCallScreen({
    super.key,
    this.doctorName = "Dr. Lorem Ipsum",
    this.doctorSpecialization = "General Physician",
    this.appointmentTime = "Time for your Appointment",
  });

  @override
  _AudioCallScreenState createState() => _AudioCallScreenState();
}

class _AudioCallScreenState extends State<AudioCallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.b1, // Dark blue background
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.b1,
                AppColors.b5, // Even darker blue
              ],
            ),
          ),
          child: Column(
            children: [
              // Header with app logo
              _buildHeader(),
              
              // Spacer
              const SizedBox(height: 40),
              
              // Doctor identification section
              _buildDoctorInfo(),
              
              // Spacer
              const SizedBox(height: 60),
              
              // Call controls section
              _buildCallControls(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Image.asset(
          'assets/calls/clinico_logo.png',
          width: 80,
          height: 80,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildDoctorInfo() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Doctor profile image with enhanced styling
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.white.withOpacity(0.3),
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 77,
              backgroundImage: AssetImage('assets/calls/doctor_female.png'),
              backgroundColor: Colors.white,
              child: Container( // Add a subtle border effect
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.white,
                    width: 5,
                  ),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 30),
          
          // Doctor name with enhanced styling
          Text(
            widget.doctorName,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Specialization
          Text(
            widget.doctorSpecialization,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white70,
            ),
          ),
          
          const SizedBox(height: 25),
          
          // Appointment time/status message with enhanced styling
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.b4.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              widget.appointmentTime,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCallControls() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: Column(
        children: [
          // Large central call button as the main focal point
          GestureDetector(
            onTap: () {
              _acceptCall();
            },
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.g1, // Olive green as per design
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 15,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Center(
                child: Image.asset(
                  'assets/calls/call_icon.png',
                  width: 50,
                  height: 50,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 30),
          
          // Accept and Decline buttons row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Decline button
              _buildControlButton(
                icon: Icons.call_end,
                label: 'Decline',
                color: AppColors.r1, // Red color
                onPressed: () {
                  // Handle call decline
                  _declineCall();
                },
              ),
              
              // Accept button
              _buildControlButton(
                icon: Icons.call,
                label: 'Accept',
                color: AppColors.g1, // Green color
                onPressed: () {
                  // Handle call acceptance
                  _acceptCall();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: 30,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

   void _acceptCall() {
     // Handle call acceptance logic
     // This would typically connect to the audio call service
     
     // Navigate to in-call screen
     Navigator.of(context).push(
       MaterialPageRoute(
         builder: (context) => InAudioCallScreen(
           doctorName: widget.doctorName,
           doctorSpecialization: widget.doctorSpecialization,
         ),
       ),
     );
   }
 
   void _declineCall() {
     // Handle call decline logic
     
     // Show a snackbar to confirm the action
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
         content: const Text('Call declined'),
         backgroundColor: AppColors.r1,
         action: SnackBarAction(
           label: 'OK',
           onPressed: () {
             // Do nothing
           },
         ),
       ),
     );
     
     // Return to previous screen after a delay
     Future.delayed(const Duration(milliseconds: 1500), () {
       Navigator.of(context).pop(); // Return to previous screen
     });
   }
}