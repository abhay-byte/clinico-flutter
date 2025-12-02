import 'package:flutter/material.dart';
import 'document_list_view.dart';

class VaccinationListView extends StatelessWidget {
  const VaccinationListView({super.key});

  @override
  Widget build(BuildContext context) {
    return DocumentListView(
      documentType: 'Vaccinations',
      pageTitle: 'Vaccinations',
      documentIcon: Icons.vaccines,
    );
  }
}