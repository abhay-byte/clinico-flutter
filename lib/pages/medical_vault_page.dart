import 'package:flutter/material.dart';
import 'document_list_view.dart';
import 'medical_vault/medical_document_upload_page.dart';

class MedicalVaultPage extends StatefulWidget {
  @override
  _MedicalVaultPageState createState() => _MedicalVaultPageState();
}

class _MedicalVaultPageState extends State<MedicalVaultPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEBF1FA), // Background color
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Header Section with curved bottom
                Container(
                  width: double.infinity,
                  height: 160, // Increased height for the header to accommodate all content
                  decoration: BoxDecoration(
                    color: Color(0xFF174880), // Header background color (b1)
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back Button and Title Row
                      Row(
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
                                "Medical Vault",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "54 documents stored",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withAlpha((0.7 * 255).round()),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      // Search Bar
                      Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 12),
                            Icon(
                              Icons.search,
                              color: Color(0xFF6A7282),
                              size: 22,
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                decoration: InputDecoration(
                                  hintText: 'Search documents...',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    color: Color(0xFF6A7282),
                                    fontSize: 15,
                                  ),
                                ),
                                onChanged: (value) {
                                  // Implement search functionality
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 160), // Further increased bottom padding to avoid FAB overlap
                    child: Column(
                      children: [
                        SizedBox(height: 16),
                        
                        // Your Health Records Banner
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          padding: EdgeInsets.all(24), // Increased padding
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Your Health Records",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF101828),
                                      ),
                                    ),
                                    SizedBox(height: 6), // Increased spacing
                                    Text(
                                      "Securely stored and organized",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF6A7282),
                                        height: 1.4, // Increased line height
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 64, // Increased size
                                height: 64,
                                decoration: BoxDecoration(
                                  color: Color(0xFFEBF1FA), // bg1
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Icon(
                                  Icons.folder_open,
                                  size: 32, // Increased icon size
                                  color: Color(0xFF174880), // b1
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(height: 16),
                        
                        // Document Category Grid (First 6 cards in 2x3 grid)
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          child: GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            padding: EdgeInsets.zero,
                            childAspectRatio: 0.85, // Adjusted aspect ratio to accommodate bigger cards
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              _buildCategoryCard(
                                icon: Icons.description,
                                iconColor: Color(0xFF248BEB), // b4
                                iconBackgroundColor: Color(0xFFE5F3FF),
                                title: "Prescriptions",
                                description: "All digital or scanned prescriptions",
                                fileCount: "12 files",
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DocumentListView(
                                        documentType: 'Prescriptions',
                                        pageTitle: 'Prescriptions',
                                        documentIcon: Icons.description,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              _buildCategoryCard(
                                icon: Icons.science,
                                iconColor: Color(0xFFFF6E6E), // r1
                                iconBackgroundColor: Color(0xFFFFE5E5),
                                title: "Lab Reports",
                                description: "CBC, BMP, lipid panel, etc.",
                                fileCount: "8 files",
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DocumentListView(
                                        documentType: 'Lab Reports',
                                        pageTitle: 'Lab Reports',
                                        documentIcon: Icons.science,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              _buildCategoryCard(
                                icon: Icons.favorite_border,
                                iconColor: Color(0xFFFFA726), // Orange/Amber
                                iconBackgroundColor: Color(0xFFF9F9E5), // Light yellow
                                title: "Radiology",
                                description: "X-ray, MRI, CT Scan",
                                fileCount: "5 files",
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DocumentListView(
                                        documentType: 'Radiology',
                                        pageTitle: 'Radiology',
                                        documentIcon: Icons.favorite_border,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              _buildCategoryCard(
                                icon: Icons.local_hospital,
                                iconColor: Color(0xFF248BEB), // b4
                                iconBackgroundColor: Color(0xFFE5F3FF),
                                title: "Discharge",
                                description: "Hospital admission details",
                                fileCount: "3 files",
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DocumentListView(
                                        documentType: 'Discharge',
                                        pageTitle: 'Discharge',
                                        documentIcon: Icons.local_hospital,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              _buildCategoryCard(
                                icon: Icons.vaccines,
                                iconColor: Color(0xFF00CC44), // Green
                                iconBackgroundColor: Color(0xFFE8FFE5),
                                title: "Vaccination",
                                description: "Immunization proof",
                                fileCount: "15 files",
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DocumentListView(
                                        documentType: 'Vaccination',
                                        pageTitle: 'Vaccinations',
                                        documentIcon: Icons.vaccines,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              _buildCategoryCard(
                                icon: Icons.healing,
                                iconColor: Color(0xFF248BEB), // b4
                                iconBackgroundColor: Color(0xFFE5F3FF),
                                title: "Doctor Notes",
                                description: "Consultation summaries or special",
                                fileCount: "7 files",
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DocumentListView(
                                        documentType: 'Doctor Notes',
                                        pageTitle: 'Doctor Notes',
                                        documentIcon: Icons.healing,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(height: 12),
                        
                        // Other Documents Card (Full width)
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DocumentListView(
                                    documentType: 'Other Documents',
                                    pageTitle: 'Other Documents',
                                    documentIcon: Icons.folder,
                                  ),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              padding: EdgeInsets.all(24), // Increased padding
                              child: Row(
                                children: [
                                  Container(
                                    width: 72, // Increased size
                                    height: 72,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF5F5F5), // Light grey
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Icon(
                                      Icons.folder,
                                      size: 36, // Increased icon size
                                      color: Color(0xFF6A7282), // ge3
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Other Documents",
                                          style: TextStyle(
                                            fontSize: 18, // Increased font size
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF101828),
                                          ),
                                        ),
                                        SizedBox(height: 6), // Increased spacing
                                        Text(
                                          "Miscellaneous files",
                                          style: TextStyle(
                                            fontSize: 14, // Increased font size
                                            color: Color(0xFF6A7282), // ge3
                                            height: 1.4, // Increased line height
                                          ),
                                        ),
                                        SizedBox(height: 16), // Increased spacing
                                        Row(
                                          children: [
                                            Text(
                                              "4 files",
                                              style: TextStyle(
                                                fontSize: 16, // Increased font size
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF248BEB), // b4
                                              ),
                                            ),
                                            Spacer(),
                                            Icon(
                                              Icons.chevron_right,
                                              size: 24, // Increased icon size
                                              color: Color(0xFFCCCCCC),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        
                        SizedBox(height: 16),
                        
                        // Keep Your Records Safe Banner
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          padding: EdgeInsets.all(20), // Increased padding
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Color(0xFFE0E0E0)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 2,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 64, // Increased size
                                height: 64,
                                decoration: BoxDecoration(
                                  color: Color(0xFF174880), // b1
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.cloud_upload,
                                  size: 32, // Increased icon size
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Keep Your Records Safe",
                                      style: TextStyle(
                                        fontSize: 17, // Increased font size
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF101828),
                                      ),
                                    ),
                                    SizedBox(height: 8), // Increased spacing
                                    Text(
                                      "Upload and store all your medical documents in one secure place. Access them anytime, anywhere.",
                                      style: TextStyle(
                                        fontSize: 15, // Increased font size
                                        color: Color(0xFF6A7282),
                                        height: 1.6, // Increased line height
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            // Floating Action Button
            Positioned(
              bottom: 24,
              right: 24,
              child: FloatingActionButton(
                onPressed: () {
                  _showUploadOptions(context);
                },
                backgroundColor: Color(0xFF248BEB), // b4
                child: Icon(Icons.add, size: 28, color: Colors.white),
                elevation: 6,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildCategoryCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBackgroundColor,
    required String title,
    required String description,
    required String fileCount,
    required VoidCallback onTap,
 }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: EdgeInsets.all(16), // Reduced padding to make card more compact
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56, // Reduced icon container size
                height: 56,
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  icon,
                  size: 28, // Reduced icon size
                  color: iconColor,
                ),
              ),
              SizedBox(height: 12), // Reduced spacing
              Text(
                title,
                style: TextStyle(
                  fontSize: 16, // Reduced font size
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF101828),
                ),
              ),
              SizedBox(height: 4), // Reduced spacing
              Text(
                description,
                style: TextStyle(
                  fontSize: 12, // Reduced font size
                  color: Color(0xFF6A7282), // ge3
                  height: 1.3, // Reduced line height
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8), // Reduced spacing
              Row(
                children: [
                  Text(
                    fileCount,
                    style: TextStyle(
                      fontSize: 14, // Reduced font size
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF248BEB), // b4
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.chevron_right,
                    size: 20, // Reduced icon size
                    color: Color(0xFFCCCCCC),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  void _showUploadOptions(BuildContext context) {
    // Navigate directly to the Medical Document Upload Page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MedicalDocumentUploadPage(),
      ),
    );
  }
}