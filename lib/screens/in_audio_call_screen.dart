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
      backgroundColor: AppColors.b1,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.b1,
                AppColors.b5,
              ],
            ),
          ),
          child: Column(
            children: [
              // Top status bar with call duration
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.call_received,
                      color: AppColors.g1,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _formatDuration(callDuration),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Doctor info section
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Doctor profile image
                    Container(
                      width: 140,
                      height: 140,
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
                        radius: 67,
                        backgroundImage: AssetImage('assets/calls/doctor_female.png'),
                        backgroundColor: Colors.white,
                      ),
                    ),
                    
                    const SizedBox(height: 30),
                    
                    // Doctor name
                    Text(
                      widget.doctorName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    
                    const SizedBox(height: 10),
                    
                    // Specialization
                    Text(
                      widget.doctorSpecialization,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Status indicator
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: _getStatusColor().withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _getStatusColor(),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _getStatusText(),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Call controls
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                child: Column(
                  children: [
                    // Control buttons row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Mute button
                        _buildControlButton(
                          icon: isMuted ? Icons.mic_off : Icons.mic,
                          label: isMuted ? 'Unmute' : 'Mute',
                          color: isMuted ? AppColors.r1 : AppColors.white,
                          onPressed: () {
                            _audioCallService.toggleMute();
                          },
                        ),
                        
                        // Speaker button
                        _buildControlButton(
                          icon: isSpeakerOn ? Icons.volume_up : Icons.volume_off,
                          label: isSpeakerOn ? 'Speaker' : 'Silent',
                          color: isSpeakerOn ? AppColors.b4 : AppColors.white,
                          onPressed: () {
                            _audioCallService.toggleSpeaker();
                          },
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 30),
                    
                    // End call button
                    GestureDetector(
                      onTap: () {
                        // Disconnect the call using the service
                        _audioCallService.disconnectCall();
                        // Return to previous screen
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.r1, // Red for end call
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 15,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.call_end,
                          size: 35,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
              color: AppColors.b5, // Darker blue background
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
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
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
