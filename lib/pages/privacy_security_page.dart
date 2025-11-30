import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacySecurityPage extends StatelessWidget {
 const PrivacySecurityPage({super.key});
  
  Future<void> _launchEmail(BuildContext context) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'privacy@clinico.com',
      query: 'subject=Privacy Question',
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      // Show error if email client is not available
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Could not launch email client"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
 }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEBF1FA), // Page background color
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              height: 110, // Fixed height for the header
              decoration: BoxDecoration(
                color: Color(0xFF174880), // Dark blue background
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                        "Privacy & Security",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Your data, your control",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withAlpha((0.7 * 255).round()),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Section 1: Top Three Policy Cards
                    // Card 1: Privacy Policy
                    _buildPolicyCard(
                      context,
                      icon: Icons.description,
                      iconBackgroundColor: Color(0xFFEBF1FA),
                      iconColor: Color(0xFF174880),
                      title: "Privacy Policy",
                      description: "Learn how we collect and use your data",
                      onTap: () {
                        // Navigate to Privacy Policy document page
                        // For now, just show a snackbar
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Navigate to Privacy Policy"),
                            backgroundColor: Color(0xFF174880),
                          ),
                        );
                      },
                    ),
                    
                    // Card 2: Terms & Conditions
                    _buildPolicyCard(
                      context,
                      icon: Icons.gavel,
                      iconBackgroundColor: Color(0xFFF3E5FF),
                      iconColor: Color(0xFF9C27B0),
                      title: "Terms & Conditions",
                      description: "Review our service usage terms",
                      onTap: () {
                        // Navigate to Terms & Conditions document page
                        // For now, just show a snackbar
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Navigate to Terms & Conditions"),
                            backgroundColor: Color(0xFF9C27B0),
                          ),
                        );
                      },
                    ),
                    
                    // Card 3: Data Security
                    _buildPolicyCard(
                      context,
                      icon: Icons.shield,
                      iconBackgroundColor: Color(0xFFE8FFE5),
                      iconColor: Color(0xFF00CC44),
                      title: "Data Security",
                      description: "Understand how we protect your information",
                      onTap: () {
                        // Navigate to Data Security information page
                        // For now, just show a snackbar
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Navigate to Data Security"),
                            backgroundColor: Color(0xFF00CC44),
                          ),
                        );
                      },
                    ),
                    
                    SizedBox(height: 16),
                    
                    // Section 2: How We Protect Your Data Header
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 16, top: 16, bottom: 12),
                      color: Color(0xFFEBF1FA), // Light background
                      child: Text(
                        "How We Protect Your Data",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF101828),
                        ),
                      ),
                    ),
                    
                    // Information Cards
                    // Card 1: End-to-End Encryption
                    _buildInfoCard(
                      icon: Icons.lock,
                      iconBackgroundColor: Color(0xFFEBF1FA),
                      iconColor: Color(0xFF174880),
                      title: "End-to-End Encryption",
                      description: "All your medical data is encrypted during transmission and storage",
                    ),
                    
                    // Card 2: Privacy Controls
                    _buildInfoCard(
                      icon: Icons.visibility,
                      iconBackgroundColor: Color(0xFFEBF1FA),
                      iconColor: Color(0xFF174880),
                      title: "Privacy Controls",
                      description: "You have full control over who can access your health information",
                    ),
                    
                    // Card 3: Secure Storage
                    _buildInfoCard(
                      icon: Icons.storage,
                      iconBackgroundColor: Color(0xFFEBF1FA),
                      iconColor: Color(0xFF174880),
                      title: "Secure Storage",
                      description: "Your data is stored in HIPAA-compliant secure servers",
                    ),
                    
                    // Card 4: Regular Audits
                    _buildInfoCard(
                      icon: Icons.verified_user,
                      iconBackgroundColor: Color(0xFFEBF1FA),
                      iconColor: Color(0xFF174880),
                      title: "Regular Audits",
                      description: "We conduct regular security audits to ensure your data safety",
                    ),
                    
                    SizedBox(height: 16),
                    
                    // Section 3: Our Commitment to You
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFEBF1FA), // Light grey-blue background
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Color(0xFFE0E0E0), width: 1),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.verified,
                                size: 24,
                                color: Color(0xFF174880),
                              ),
                              SizedBox(width: 12),
                              Text(
                                "Our Commitment to You",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF101828),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Text(
                            "At Clinico, we are committed to protecting your privacy and maintaining the security of your personal information.",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF101828),
                              height: 1.5,
                            ),
                          ),
                          SizedBox(height: 12),
                          
                          // Commitment List
                          _buildCommitmentItem("We never sell your personal data to third parties"),
                          _buildCommitmentItem("You can request to delete your data at any time"),
                          _buildCommitmentItem("We comply with HIPAA and GDPR regulations"),
                          _buildCommitmentItem("We notify you immediately of any security incidents"),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: 12),
                    
                    // Section 4: Your Data Rights
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withAlpha(50),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Your Data Rights",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF101828),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "You have the right to:",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF6A7282),
                            ),
                          ),
                          SizedBox(height: 12),
                          
                          // Rights List
                          _buildRightsItem("Access", "your personal data at any time"),
                          _buildRightsItem("Correct", "inaccurate or incomplete information"),
                          _buildRightsItem("Export", "your data in a portable format"),
                          _buildRightsItem("Delete", "your account and all associated data"),
                          _buildRightsItem("Object", "to certain types of data processing"),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: 12),
                    
                    // Section 5: Privacy Questions
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withAlpha(50),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            "Privacy Questions?",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF101828),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 8),
                          Text(
                            "If you have any questions or concerns about your privacy, please contact our Data Protection Officer.",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF6A7282),
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 12),
                          GestureDetector(
                            onTap: () {
                              _launchEmail(context);
                            },
                            child: Text(
                              "privacy@clinico.com",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF248BEB), // Blue link color
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: 16),
                    
                    // Footer: Last Updated
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        "Last Updated: November 11, 2025",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF99A1AF), // Light grey
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // Helper method to build policy cards (Privacy Policy, Terms & Conditions, Data Security)
  Widget _buildPolicyCard(
    BuildContext context, {
    required IconData icon,
    required Color iconBackgroundColor,
    required Color iconColor,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(50),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: iconBackgroundColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 24,
            color: iconColor,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF101828),
          ),
        ),
        subtitle: Text(
          description,
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF6A7282),
            height: 1.3,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: Color(0xFF99A1AF),
          size: 24,
        ),
        onTap: onTap,
      ),
    );
  }
  
  // Helper method to build information cards
  Widget _buildInfoCard({
    required IconData icon,
    required Color iconBackgroundColor,
    required Color iconColor,
    required String title,
    required String description,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(50),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconBackgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 24,
              color: iconColor,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF101828),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6A7282),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  // Helper method to build commitment list items
  Widget _buildCommitmentItem(String text) {
    return Padding(
      padding: EdgeInsets.only(top: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle,
            size: 20,
            color: Color(0xFF00CC44), // Green checkmark
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF101828),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  // Helper method to build rights list items with bold keywords
  Widget _buildRightsItem(String boldText, String regularText) {
    return Padding(
      padding: EdgeInsets.only(top: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 7, right: 8),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: Color(0xFF248BEB), // Blue bullet
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '$boldText ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: regularText),
                ],
                style: TextStyle(fontSize: 14, color: Color(0xFF101828)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}