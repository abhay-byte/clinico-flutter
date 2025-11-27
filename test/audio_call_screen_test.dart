import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clinico/screens/audio_call_screen.dart';
import 'package:clinico/screens/in_audio_call_screen.dart';

void main() {
  group('Audio Call Screen Tests', () {
    testWidgets('AudioCallScreen should build without errors', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AudioCallScreen(),
        ),
      );

      // Verify that the screen contains expected elements
      expect(find.byType(Container), findsWidgets);
      expect(find.byType(Image), findsOneWidget);
      expect(find.text('Dr. Lorem Ipsum'), findsOneWidget);
      expect(find.text('Time for your Appointment'), findsOneWidget);
      expect(find.byType(GestureDetector), findsNWidgets(3)); // Accept, Decline, and central button
    });

    testWidgets('InAudioCallScreen should build without errors', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: InAudioCallScreen(),
        ),
      );

      // Verify that the screen contains expected elements
      expect(find.byType(Container), findsWidgets);
      expect(find.byType(Image), findsOneWidget);
      expect(find.text('Dr. Lorem Ipsum'), findsOneWidget);
      expect(find.byType(GestureDetector), findsNWidgets(3)); // Mute, Speaker, and End Call buttons
    });

    testWidgets('AudioCallScreen should navigate to InAudioCallScreen when accept is pressed', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AudioCallScreen(),
        ),
      );

      // Find and tap the accept button (the central call button)
      final acceptButton = find.byType(GestureDetector).at(1); // Central button
      await tester.tap(acceptButton);
      await tester.pump(); // Trigger navigation
      
      // Verify that we're now on the InAudioCallScreen
      expect(find.byType(InAudioCallScreen), findsOneWidget);
    });
  });
}