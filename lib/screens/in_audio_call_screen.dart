/// In Audio Call Screen
///
/// This screen represents the active audio call state when the user has accepted
/// the incoming appointment call. It displays call controls like mute, speaker,
/// and end call, along with the call duration timer and doctor information.
library;

import 'package:flutter/material.dart';
import 'dart:async';
import '../constants/colors.dart';
import '../services/audio_call_service.dart';

class InAudioCallScreen extends StatefulWidget {
  final String doctorName;
  final String doctorSpecialization;

  const InAudioCallScreen({
    super.key,
    this.doctorName = "Dr. Lorem Ipsum",
    this.doctorSpecialization = "General Physician",
  });

  @override
  _InAudioCallScreenState createState() => _InAudioCallScreenState();
}

class _InAudioCallScreenState extends State<InAudioCallScreen> {
  final AudioCallService _audioCallService = AudioCallService();
  late StreamSubscription<bool> _muteSubscription;
  late StreamSubscription<bool> _speakerSubscription;
  late StreamSubscription<int> _durationSubscription;
  late StreamSubscription<CallState> _stateSubscription;
  bool isMuted = false;
  bool isSpeakerOn = false;
  int callDuration = 0;
  CallState callState = CallState.idle;

  @override
  void initState() {
    super.initState();

    // Subscribe to audio call service streams
    _muteSubscription = _audioCallService.muteStream.listen((muted) {
      setState(() {
        isMuted = muted;
      });
    });

    _speakerSubscription = _audioCallService.speakerStream.listen((speakerOn) {
      setState(() {
        isSpeakerOn = speakerOn;
      });
    });

    _durationSubscription = _audioCallService.durationStream.listen((duration) {
      setState(() {
        callDuration = duration;
      });
    });

    _stateSubscription = _audioCallService.stateStream.listen((state) {
      setState(() {
        callState = state;
      });
    });

    // Start the call
    _audioCallService.connectCall();
  }

  String _formatDuration(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _muteSubscription.cancel();
    _speakerSubscription.cancel();
    _durationSubscription.cancel();
    _stateSubscription.cancel();
    _audioCallService.disconnectCall();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF0F4F8,
      ), // Use very light blue/grey background as requested
      body: SafeArea(
        child: Column(
          children: [
            // Top Logo: clinic_logo with 120x120 frame, no shadow
            Container(
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
            ),

            const SizedBox(height: 40),

            // Doctor info section - same as incoming screen
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Doctor profile image - large circular, no shadow
                  Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: CircleAvatar(
                      radius: 77,
                      backgroundImage: AssetImage(
                        'assets/calls/doctor_female.png',
                      ),
                      backgroundColor: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Doctor name - Title, Bold
                  Text(
                    widget.doctorName,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Specialization
                  Text(
                    widget.doctorSpecialization,
                    style: const TextStyle(fontSize: 18, color: Colors.grey),
                  ),

                  const SizedBox(height: 25),

                  // Text: 'Voice Call' with timer '0:00'
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.b4.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Voice Call',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _formatDuration(callDuration),
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Controls: White Rounded Rectangle container (like a bottom sheet)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Speaker: White circle, black icon, text 'Speaker' below
                  _buildBottomControlButton(
                    icon: isSpeakerOn ? Icons.volume_up : Icons.volume_off,
                    text: 'Speaker',
                    color: Colors.black,
                    backgroundColor: Colors.white,
                    onPressed: () {
                      _audioCallService.toggleSpeaker();
                    },
                  ),

                  // Mute: White circle, black icon, text 'Mute' below
                  _buildBottomControlButton(
                    icon: isMuted ? Icons.mic_off : Icons.mic,
                    text: 'Mute',
                    color: Colors.black,
                    backgroundColor: Colors.white,
                    onPressed: () {
                      _audioCallService.toggleMute();
                    },
                  ),

                  // Leave: Red circle, white phone hang-up icon, text 'Leave' below
                  _buildBottomControlButton(
                    icon: Icons.call_end,
                    text: 'Leave',
                    color: Colors.white,
                    backgroundColor: AppColors.r1,
                    onPressed: () {
                      // Disconnect the call using the service
                      _audioCallService.disconnectCall();
                      // Return to previous screen
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomControlButton({
    required IconData icon,
    required String text,
    required Color color,
    required Color backgroundColor,
    required VoidCallback onPressed,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, size: 30, color: color),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor() {
    switch (callState) {
      case CallState.connecting:
        return AppColors.b4; // Blue for connecting
      case CallState.connected:
        return AppColors.g1; // Green for connected
      case CallState.disconnected:
        return AppColors.r1; // Red for disconnected
      case CallState.error:
        return AppColors.r1; // Red for error
      default:
        return AppColors.g1; // Default to green
    }
  }

  String _getStatusText() {
    switch (callState) {
      case CallState.connecting:
        return 'Connecting...';
      case CallState.connected:
        return 'In Call';
      case CallState.disconnected:
        return 'Call Ended';
      case CallState.error:
        return 'Connection Error';
      default:
        return 'In Call';
    }
  }
}
