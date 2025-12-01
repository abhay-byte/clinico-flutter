import 'package:flutter/material.dart';
import 'document_list_view.dart';

class LabReportsListView extends StatelessWidget {
  const LabReportsListView({super.key});

  @override
 Widget build(BuildContext context) {
    return DocumentListView(
      documentType: 'Lab Reports',
      pageTitle: 'Lab Reports',
      documentIcon: Icons.description,
    );
  }
}