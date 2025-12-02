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

enum CallStatus { incoming, active, ended }

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
  CallStatus callStatus = CallStatus.incoming;

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
          child: callStatus == CallStatus.incoming
              ? _buildIncomingCallView()
              : callStatus == CallStatus.active
              ? _buildActiveCallView()
              : _buildEndedCallView(),
        ),
      ),
    );
  }

  Widget _buildIncomingCallView() {
    return Column(
      children: [
        // Header with app logo - fixed size 120x120 without shadow
        _buildHeader(),

        // Spacer
        const SizedBox(height: 40),

        // Doctor identification section
        _buildDoctorInfo(),

        // Spacer
        const SizedBox(height: 60),

        // Call controls section with floating button
        _buildFloatingCallControls(),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white, // White background of exact logo size
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            'assets/calls/clinico_logo.png',
            width: 120,
            height: 120,
            fit: BoxFit.contain,
          ),
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
              child: Container(
                // Add a subtle border effect
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white, width: 5),
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
            style: const TextStyle(fontSize: 18, color: Colors.white70),
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

  Widget _buildFloatingCallControls() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Blue capsule container
          Container(
            height: 80,
            margin: const EdgeInsets.only(
              bottom: 20,
            ), // Space for floating button
            decoration: BoxDecoration(
              color: AppColors.b4, // Blue color
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Left: 'Decline' text
                Expanded(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.call_end, color: Colors.white, size: 20),
                        const SizedBox(width: 8),
                        const Text(
                          'Decline',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Spacer in the middle
                const Spacer(),
                // Right: 'Accept' text
                Expanded(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.phone, color: Colors.white, size: 20),
                        const SizedBox(width: 8),
                        const Text(
                          'Accept',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Floating white circular button with drag functionality
          Transform.translate(
            offset: const Offset(0, -30), // Float above the blue capsule
            child: _buildDraggableCallButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildDraggableCallButton() {
    return DraggableCallButton(
      onAccept: _acceptCall,
      onDecline: _declineCall,
      size: 100, // Frame 100x100 as requested
    );
  }

  Widget _buildActiveCallView() {
    return InAudioCallScreen(
      doctorName: widget.doctorName,
      doctorSpecialization: widget.doctorSpecialization,
    );
  }

  Widget _buildEndedCallView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.call_end, color: Colors.white, size: 80),
          const SizedBox(height: 20),
          const Text(
            'Call Ended',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.b4),
            child: const Text('Back to App'),
          ),
        ],
      ),
    );
  }

  void _acceptCall() {
    print("Call Accepted");
    setState(() {
      callStatus = CallStatus.active;
    });
  }

  void _declineCall() {
    print("Call Declined");
    setState(() {
      callStatus = CallStatus.ended;
    });
  }
}

// Separate widget for the draggable call button
class DraggableCallButton extends StatefulWidget {
  final VoidCallback onAccept;
  final VoidCallback onDecline;
  final double size;

  const DraggableCallButton({
    Key? key,
    required this.onAccept,
    required this.onDecline,
    this.size = 100, // Default to 10 as requested
  }) : super(key: key);

  @override
  _DraggableCallButtonState createState() => _DraggableCallButtonState();
}

class _DraggableCallButtonState extends State<DraggableCallButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _xDragOffset = 0.0;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // Change the button color based on drag position
        Color buttonColor = Colors.white;
        IconData buttonIcon = Icons.phone;
        Color iconColor = AppColors.g1; // Green for accept

        if (_xDragOffset < -50) {
          // When dragging left, change to decline color/icon
          buttonColor = const Color(0xFFEF4444); // Red for decline
          buttonIcon = Icons.call_end;
          iconColor = Colors.white;
        } else if (_xDragOffset > 50) {
          // When dragging right, keep accept color/icon but make it more prominent
          buttonColor = AppColors.g1; // Green for accept
          buttonIcon = Icons.phone;
          iconColor = Colors.white;
        }

        return Transform.translate(
          offset: Offset(_xDragOffset, -30), // Float above the blue capsule
          child: GestureDetector(
            onPanStart: (details) {
              setState(() {
                _isDragging = true;
              });
            },
            onPanUpdate: (details) {
              setState(() {
                _xDragOffset += details.delta.dx;
                // Limit the drag to prevent going off-screen
                if (_xDragOffset < -150) _xDragOffset = -150;
                if (_xDragOffset > 150) _xDragOffset = 150;
              });
            },
            onPanEnd: (details) {
              if (_xDragOffset > 100) {
                // Dragged sufficiently to the right - accept call
                widget.onAccept();
                _resetButton();
              } else if (_xDragOffset < -100) {
                // Dragged sufficiently to the left - decline call
                widget.onDecline();
                _resetButton();
              } else {
                // Not dragged far enough - animate back to center
                _animateToCenter();
              }
              setState(() {
                _isDragging = false;
              });
            },
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                color: buttonColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Center(
                child: Icon(buttonIcon, color: iconColor, size: 35),
              ),
            ),
          ),
        );
      },
    );
  }

  void _animateToCenter() {
    _controller.reset();
    _controller.duration = const Duration(milliseconds: 300);
    _controller.forward();

    final curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    final animation = Tween<double>(
      begin: _xDragOffset,
      end: 0.0,
    ).animate(curvedAnimation);

    animation.addListener(() {
      setState(() {
        _xDragOffset = animation.value;
      });
    });
  }

  void _resetButton() {
    setState(() {
      _xDragOffset = 0.0;
    });
  }
}
