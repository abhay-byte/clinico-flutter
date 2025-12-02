import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clinico/pages/document_view_page.dart';

void main() {
  group('DocumentViewPage Tests', () {
    testWidgets('should build without errors', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DocumentViewPage(
            documentTitle: 'CBC Report – 09 Nov 2025',
            documentType: 'Lab Report (CBC)',
            fileName: 'cbc_report_09nov2025.pdf',
            uploadDate: '09 Nov 2025',
            uploadTime: '10:30 AM',
            uploadedBy: 'Self',
            comments: 'Routine blood check',
            doctor: 'Dr. Lorem Ipsum',
            linkedTo: 'Appointment #A12345',
            fileType: 'pdf',
            enableZoom: true,
          ),
        ),
      );

      // Verify that the page builds without errors
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.text('CBC Report – 09 Nov 2025'), findsOneWidget);
      expect(find.text('Lab Report (CBC)'), findsWidgets); // Appears in app bar and details section
      expect(find.text('cbc_report_09nov2025.pdf'), findsNWidgets(2)); // Appears in preview and details
      expect(find.text('09 Nov 2025'), findsOneWidget);
      expect(find.text('10:30 AM'), findsOneWidget);
      expect(find.text('Self'), findsOneWidget);
      expect(find.text('Routine blood check'), findsOneWidget);
      expect(find.text('Dr. Lorem Ipsum'), findsOneWidget);
      expect(find.text('Appointment #A12345'), findsOneWidget);
    });

    testWidgets('should show zoom controls when enableZoom is true', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DocumentViewPage(
            documentTitle: 'Test Report',
            documentType: 'Lab Report',
            fileName: 'test.pdf',
            uploadDate: '09 Nov 2025',
            uploadTime: '10:30 AM',
            uploadedBy: 'Self',
            fileType: 'pdf',
            enableZoom: true,
          ),
        ),
      );

      // Verify zoom controls are present
      expect(find.byIcon(Icons.zoom_in), findsOneWidget);
      expect(find.byIcon(Icons.zoom_out), findsOneWidget);
    });

    testWidgets('should hide zoom controls when enableZoom is false', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DocumentViewPage(
            documentTitle: 'Test Report',
            documentType: 'Lab Report',
            fileName: 'test.pdf',
            uploadDate: '09 Nov 2025',
            uploadTime: '10:30 AM',
            uploadedBy: 'Self',
            fileType: 'pdf',
            enableZoom: false,
          ),
        ),
      );

      // Verify zoom controls are not present
      expect(find.byIcon(Icons.zoom_in), findsNothing);
      expect(find.byIcon(Icons.zoom_out), findsNothing);
    });

    testWidgets('should show correct file icon based on file type', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DocumentViewPage(
            documentTitle: 'Test Report',
            documentType: 'Lab Report',
            fileName: 'test.pdf',
            uploadDate: '09 Nov 2025',
            uploadTime: '10:30 AM',
            uploadedBy: 'Self',
            fileType: 'pdf',
            enableZoom: false,
          ),
        ),
      );

      // Verify PDF icon is shown
      expect(find.byIcon(Icons.description), findsWidgets);
    });

    testWidgets('should show linked appointment button when linkedTo is provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DocumentViewPage(
            documentTitle: 'Test Report',
            documentType: 'Lab Report',
            fileName: 'test.pdf',
            uploadDate: '09 Nov 2025',
            uploadTime: '10:30 AM',
            uploadedBy: 'Self',
            linkedTo: 'Appointment #A12345',
            fileType: 'pdf',
            enableZoom: false,
          ),
        ),
      );

      // Verify linked appointment button is shown
      expect(find.text('View Linked Appointment'), findsOneWidget);
    });

    testWidgets('should not show linked appointment button when linkedTo is empty', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DocumentViewPage(
            documentTitle: 'Test Report',
            documentType: 'Lab Report',
            fileName: 'test.pdf',
            uploadDate: '09 Nov 2025',
            uploadTime: '10:30 AM',
            uploadedBy: 'Self',
            linkedTo: '',
            fileType: 'pdf',
            enableZoom: false,
          ),
        ),
      );

      // Verify linked appointment button is not shown
      expect(find.text('View Linked Appointment'), findsNothing);
    });
  });
}