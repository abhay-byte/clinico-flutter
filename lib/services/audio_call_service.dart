/// Audio Call Service
///
/// This service handles the audio call functionality including connecting,
/// disconnecting, muting, and speaker controls. In a real implementation,
/// this would interface with a VoIP SDK like Agora, Twilio, or Jitsi.
library;
import 'dart:async';

enum CallState { idle, connecting, connected, disconnected, error }

class AudioCallService {
  static final AudioCallService _instance = AudioCallService._internal();
 factory AudioCallService() => _instance;
  AudioCallService._internal();

  CallState _callState = CallState.idle;
  bool _isMuted = false;
 bool _isSpeakerOn = false;
 Timer? _callTimer;
  int _callDuration = 0;
  String? _error;
  
  // Streams for call state updates
  final StreamController<CallState> _stateController = StreamController<CallState>.broadcast();
  final StreamController<bool> _muteController = StreamController<bool>.broadcast();
 final StreamController<bool> _speakerController = StreamController<bool>.broadcast();
  final StreamController<int> _durationController = StreamController<int>.broadcast();
  final StreamController<String?> _errorController = StreamController<String?>.broadcast();

  // Public getters for streams
 Stream<CallState> get stateStream => _stateController.stream;
  Stream<bool> get muteStream => _muteController.stream;
  Stream<bool> get speakerStream => _speakerController.stream;
  Stream<int> get durationStream => _durationController.stream;
  Stream<String?> get errorStream => _errorController.stream;

  // Public getters for current state
  CallState get callState => _callState;
  bool get isMuted => _isMuted;
  bool get isSpeakerOn => _isSpeakerOn;
  int get callDuration => _callDuration;
  String? get error => _error;

  /// Connect to an audio call
  Future<bool> connectCall() async {
    try {
      // Update state to connecting
      _callState = CallState.connecting;
      _stateController.add(_callState);
      
      // Simulate connection process
      await Future.delayed(const Duration(seconds: 2));
      
      // Check if the call was cancelled during connection
      if (_callState == CallState.disconnected) {
        return false;
      }
      
      _callState = CallState.connected;
      _callDuration = 0;
      _error = null;
      
      // Start call timer
      _startCallTimer();
      
      // Notify listeners
      _stateController.add(_callState);
      _errorController.add(_error);
      
      return true;
    } catch (e) {
      _callState = CallState.error;
      _error = e.toString();
      _stateController.add(_callState);
      _errorController.add(_error);
      return false;
    }
  }

  /// Disconnect from the audio call
  Future<void> disconnectCall() async {
    _callState = CallState.disconnected;
    _callTimer?.cancel();
    _error = null;
    
    // Notify listeners
    _stateController.add(_callState);
    _errorController.add(_error);
  }

  /// Toggle mute state
  void toggleMute() {
    _isMuted = !_isMuted;
    _muteController.add(_isMuted);
  }

  /// Toggle speaker state
 void toggleSpeaker() {
    _isSpeakerOn = !_isSpeakerOn;
    _speakerController.add(_isSpeakerOn);
  }

  /// Start the call duration timer
  void _startCallTimer() {
    _callTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _callDuration++;
      _durationController.add(_callDuration);
    });
  }

  /// Clean up resources
 void dispose() {
    _callTimer?.cancel();
    _stateController.close();
    _muteController.close();
    _speakerController.close();
    _durationController.close();
    _errorController.close();
  }
}