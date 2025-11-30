import 'package:flutter/material.dart';

class DocumentListView extends StatefulWidget {
  final String documentType;
  final String pageTitle;
  final IconData documentIcon;

  const DocumentListView({
    super.key,
    required this.documentType,
    required this.pageTitle,
    required this.documentIcon,
 });

  @override
  State<DocumentListView> createState() => _DocumentListViewState();
}

class _DocumentListViewState extends State<DocumentListView> {

  final TextEditingController _searchController = TextEditingController();
  String _selectedSortOption = 'Date';
  List<Map<String, dynamic>> _documents = [];

  @override
  void initState() {
    super.initState();
    _documents = _generateSampleDocuments(widget.documentType);
  }

  List<Map<String, dynamic>> _generateSampleDocuments(String documentType) {
    // Sample documents data - filtered based on document type
    List<Map<String, dynamic>> allDocuments = [
      {
        'title': 'Prescription #001',
        'date': '2024-11-25',
        'comments': 'Regular checkup medication',
        'icon': Icons.description,
        'type': 'Prescriptions',
      },
      {
        'title': 'Prescription #002',
        'date': '2024-11-20',
        'comments': 'Antibiotic treatment',
        'icon': Icons.description,
        'type': 'Prescriptions',
      },
      {
        'title': 'Lab Report #02',
        'date': '2024-11-20',
        'comments': 'Blood test results',
        'icon': Icons.description,
        'type': 'Lab Reports',
      },
      {
        'title': 'Lab Report #03',
        'date': '2024-11-18',
        'comments': 'Urine analysis',
        'icon': Icons.description,
        'type': 'Lab Reports',
      },
      {
        'title': 'Vaccination Record',
        'date': '2024-11-15',
        'comments': 'Annual flu shot',
        'icon': Icons.vaccines,
        'type': 'Vaccinations',
      },
      {
        'title': 'COVID Vaccine',
        'date': '2024-11-10',
        'comments': 'Booster dose',
        'icon': Icons.vaccines,
        'type': 'Vaccinations',
      },
      {
        'title': 'Discharge Summary',
        'date': '2024-11-10',
        'comments': 'Post-surgery care instructions',
        'icon': Icons.description,
        'type': 'Discharge',
      },
      {
        'title': 'Surgery Report',
        'date': '2024-11-05',
        'comments': 'Surgical procedure notes',
        'icon': Icons.description,
        'type': 'Discharge',
      },
      {
        'title': 'Doctor Notes',
        'date': '2024-11-05',
        'comments': 'Follow-up appointment notes',
        'icon': Icons.note_alt,
        'type': 'Doctor Notes',
      },
      {
        'title': 'Consultation Notes',
        'date': '2024-11-01',
        'comments': 'Initial consultation',
        'icon': Icons.note_alt,
        'type': 'Doctor Notes',
      },
      {
        'title': 'X-Ray Report',
        'date': '2024-11-01',
        'comments': 'Chest X-ray findings',
        'icon': Icons.image,
        'type': 'Radiology',
      },
      {
        'title': 'MRI Scan',
        'date': '2024-10-28',
        'comments': 'Brain scan results',
        'icon': Icons.image,
        'type': 'Radiology',
      },
    ];

    // Filter documents based on the requested document type
    if (documentType == 'Other Documents') {
      // For "Other Documents", return all types except the specific categories
      return allDocuments;
    } else {
      return allDocuments.where((doc) => doc['type'] == documentType).toList();
    }
 }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA), // Background color
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Header Section with curved bottom
                Container(
                  width: double.infinity,
                  height: 120, // Fixed height for the header
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF1E4A7E), // Header gradient start
                        Color(0xFF2563B4), // Header gradient end
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Row(
                    children: [
                      // Back Button
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 24,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      SizedBox(width: 8),
                      // Title and Subtitle
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.pageTitle,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Manage your ${widget.documentType}",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Search Bar and Sort Options
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Search Bar
                      Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search ${widget.documentType}...',
                            hintStyle: TextStyle(color: Color(0xFF6A7282)),
                            prefixIcon: Icon(
                              Icons.search,
                              size: 22,
                              color: Color(0xFF6A7282),
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          ),
                        ),
                      ),
                      
                      SizedBox(height: 12),
                      
                      // Sort Dropdown
                      Container(
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Color(0xFFE5E5E5)),
                        ),
                        padding: EdgeInsets.only(left: 16, right: 12),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: _selectedSortOption,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              size: 24,
                              color: Color(0xFF101828),
                            ),
                            items: <String>['Date', 'Title', 'Type']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  'Sort by $value',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF6A7282),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedSortOption = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Document List
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _documents.length,
                    itemBuilder: (context, index) {
                      final document = _documents[index];
                      return _buildDocumentCard(document);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentCard(Map<String, dynamic> document) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Icon Bubble
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Color(0xFFE1FBFF), // g3 — Light Cyan
                borderRadius: BorderRadius.circular(24),
              ),
              child: Icon(
                document['icon'] ?? widget.documentIcon,
                color: Color(0xFF248BEB), // b4 — Bright Blue
                size: 26,
              ),
            ),
            
            SizedBox(width: 16),
            
            // Document Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Document Title
                  Text(
                    document['title'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600, // SemiBold
                      color: Color(0xFF101828),
                    ),
                  ),
                  
                  SizedBox(height: 6),
                  
                  // Date Row
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Color(0xFF6A7282),
                      ),
                      SizedBox(width: 4),
                      Text(
                        document['date'],
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF6A7282),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 12),
                  
                  // Comments Box
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: Color(0xFFF3F4F6), // ge3 — Light Neutral Gray
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      document['comments'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF101828),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // More Actions Icon
            IconButton(
              icon: Icon(
                Icons.more_vert,
                size: 22,
                color: Color(0xFF6A7282),
              ),
              onPressed: () {
                _showDocumentOptions(document);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDocumentOptions(Map<String, dynamic> document) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.download, color: Color(0xFF101828)),
                title: Text('Download'),
                onTap: () {
                  Navigator.pop(context);
                  // Handle download
                },
              ),
              ListTile(
                leading: Icon(Icons.share, color: Color(0xFF101828)),
                title: Text('Share'),
                onTap: () {
                  Navigator.pop(context);
                  // Handle share
                },
              ),
              ListTile(
                leading: Icon(Icons.delete, color: Color(0xFFD32F2F)),
                title: Text('Delete', style: TextStyle(color: Color(0xFFD32F2F))),
                onTap: () {
                  Navigator.pop(context);
                  // Handle delete
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}