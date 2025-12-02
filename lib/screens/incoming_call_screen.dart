import 'package:flutter/material.dart';
import 'in_audio_call_screen.dart';

class IncomingCallScreen extends StatefulWidget {
  final bool isVideoCall;

  const IncomingCallScreen({Key? key, this.isVideoCall = true})
    : super(key: key);

  @override
  _IncomingCallScreenState createState() => _IncomingCallScreenState();
}

class _IncomingCallScreenState extends State<IncomingCallScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8), // Light grey-blue background
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(), // Add Spacer above the logo so it's not stuck to the very top edge
            // Top: Larger clinico_logo.png with more padding and soft shadow
            Container(
              padding: const EdgeInsets.only(
                top: 20, // Reduced top padding since we have Spacer above
                bottom: 20,
              ), // More padding from top
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white, // White background of exact logo size
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/calls/clinico_logo.png',
                    height: 120,
                    width: 120,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const Spacer(
              flex: 2,
            ), // Add more space before profile image to move it higher
            // Middle: Large doctor_logo.png inside a circular avatar (moved higher) - NO SHADOW
            Container(
              margin: const EdgeInsets.only(
                bottom: 10,
              ), // Reduced bottom margin to move higher
              child: CircleAvatar(
                radius: 90,
                backgroundImage: AssetImage('assets/calls/doctor_female.png'),
                backgroundColor: Colors.white,
              ),
            ),
            // Text: 'Dr. Lorem Ipsum' (Bold and larger - Title size) and 'Time for your Appointment' (Grey and smaller)
            const Text(
              "Dr. Lorem Ipsum",
              style: TextStyle(
                fontSize: 36, // Increased font size
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(
              height: 24,
            ), // More vertical spacing between doctor's name and subtext
            const Text(
              "Time for your Appointment",
              style: TextStyle(
                fontSize: 20, // Increased font size
                fontWeight: FontWeight.normal,
                color: Color(0xFF64748B), // Gray color
              ),
            ),
            const Spacer(),
            // Bottom Action Bar: Using ZStack-like behavior with layers
            Container(
              margin: const EdgeInsets.only(
                bottom:
                    10, // Reduced bottom margin to accommodate the floating button
              ),
              height: 80, // Standard height for pill-shaped container
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // Layer 1 (Back): Blue Capsule containing the 'Decline' and 'Accept' text
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    height: 80, // Standard height for pill-shaped container
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B82F6), // Blue color
                      borderRadius: BorderRadius.circular(
                        40,
                      ), // Pill-shaped (Capsule equivalent)
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
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
                                Icon(
                                  Icons.call_end,
                                  color: Colors.white,
                                  size: 20,
                                ),
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
                        // Spacer in the middle (as requested in HStack with Spacer)
                        const Spacer(),
                        // Right: 'Accept' text
                        Expanded(
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                  size: 20,
                                ),
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
                  // Layer 2 (Front): The white circular call button
                  // Apply padding(.bottom, 20) equivalent with negative Y offset to float above the blue capsule
                  Transform.translate(
                    offset: Offset(
                      0,
                      -20, // Negative Y offset to move up and break the top edge of the blue capsule
                    ), // Apply negative offset to make it float above the blue bar
                    child: _buildDraggableCallButton(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to build the draggable call button
  Widget _buildDraggableCallButton() {
    return DraggableCallButton(
      onAccept: _acceptCall,
      onDecline: _declineCall,
      size: 100, // Pass the size parameter
    );
  }

  void _acceptCall() {
    print("Call Accepted");
    // Navigate to call screen
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => InAudioCallScreen(
          doctorName: "Dr. Lorem Ipsum",
          doctorSpecialization: "General Physician",
        ),
      ),
    );
  }

  void _declineCall() {
    print("Call Declined");
    Navigator.pop(context);
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
    this.size = 80, // Default to 80, but allow 100 as requested
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
        Color iconColor = const Color(0xFF22C55E); // Green for accept

        if (_xDragOffset < -50) {
          // When dragging left, change to decline color/icon
          buttonColor = const Color(0xFFEF4444); // Red for decline
          buttonIcon = Icons.call_end;
          iconColor = Colors.white;
        } else if (_xDragOffset > 50) {
          // When dragging right, keep accept color/icon but make it more prominent
          buttonColor = const Color(0xFF22C55E); // Green for accept
          buttonIcon = Icons.phone;
          iconColor = Colors.white;
        }

        return Transform.translate(
          offset: Offset(
            _xDragOffset,
            -20, // Changed from -25 to -20 to match the requested offset
          ), // Increased negative vertical offset for better overlap
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
