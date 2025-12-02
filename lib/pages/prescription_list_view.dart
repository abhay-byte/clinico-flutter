import 'package:flutter/material.dart';
import 'document_list_view.dart';

class PrescriptionListView extends StatelessWidget {
  const PrescriptionListView({super.key});

  @override
  Widget build(BuildContext context) {
    return DocumentListView(
      documentType: 'Prescriptions',
      pageTitle: 'Prescriptions',
      documentIcon: Icons.description,
    );
  }
}