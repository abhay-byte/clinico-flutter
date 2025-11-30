import 'package:flutter/material.dart';
import 'profile_details_page.dart';
import 'medicine_reminders_page.dart';
import 'settings_page.dart';
import 'help_and_support_page.dart';
import 'privacy_security_page.dart';
import 'medical_vault_page.dart';
import 'document_list_view.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
 Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEBF1FA), // bg1
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Color(0xFFEBF1FA), // bg1
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Title
                  Text(
                    "My Profile",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF174880), // b1
                    ),
                  ),
                  // Logo/Avatar - Using brand_logo.png as requested
                  Image.asset(
                    'assets/user/brand_logo.png',
                    width: 48,
                    height: 48,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
            
            // Profile Card
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // User Avatar
                  Stack(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Color(0xFF174880), // b1
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Icon(
                          Icons.person,
                          size: 35,
                          color: Colors.white,
                        ),
                      ),
                      // Camera/Edit Badge
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Color(0xFF2C5300), // Primary blue
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(width: 16),
                  
                  // User Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Lorem Ipsum Dolor",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF101828), // Dark text
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.edit,
                                size: 20,
                                color: Color(0xFF174880), // b1
                              ),
                              onPressed: () {
                                // Edit profile functionality
                              },
                            ),
                          ],
                        ),
                        
                        SizedBox(height: 4),
                        
                        Text(
                          "Patient ID: CLN-10234",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF6A7282), // ge3
                          ),
                        ),
                        
                        SizedBox(height: 8),
                        
                        // Verified Badge
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Color(0xFFE1FFBF), // Light green
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.check_circle,
                                size: 14,
                                color: Color(0xFF0024A), // g4/g5
                              ),
                              SizedBox(width: 4),
                              Text(
                                "Verified User",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF00224A), // g4/g5
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Membership Info
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Member Since",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6A7282), // ge3
                        ),
                      ),
                      Text(
                        "Jan 2025",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF101828), // Dark text
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Last Sync",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6A7282), // ge3
                        ),
                      ),
                      Text(
                        "09 Nov 2025, 08:20 PM",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF101828), // Dark text
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 16),
            
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Account & Health Section Header
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      color: Color(0xFFEBF1FA), // bg1
                      child: Text(
                        "Account & Health",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF101828), // Dark text
                        ),
                      ),
                    ),
                    
                    // Account & Health Menu Items
                    _buildMenuItem(
                      iconPath: 'assets/user/profile_details_icon.png',
                      title: "Profile Details",
                      subtitle: "Personal info, contact & preferences",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileDetailsPage(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      iconPath: 'assets/user/appointments_icon.png',
                      title: "Appointments",
                      subtitle: "Manage doctor appointments",
                      onTap: () {
                        // Navigate to Appointments page
                      },
                    ),
                    _buildMenuItem(
                      iconPath: 'assets/user/prescription_list_icon.png',
                      title: "Prescription List",
                      subtitle: "All digital prescriptions",
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
                    _buildMenuItem(
                      iconPath: 'assets/user/medicine_reminder_icon.png',
                      title: "Medicine Reminders",
                      subtitle: "Set & view medicine alerts",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MedicineRemindersPage(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      iconPath: 'assets/user/medical_vault_icon.png',
                      title: "Medical Vault",
                      subtitle: "Secure storage for health reports",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MedicalVaultPage(),
                          ),
                        );
                      },
                    ),
                    
                    // Wellness & Learning Section Header
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      color: Color(0xFFEBF1FA), // bg1
                      child: Text(
                        "Wellness & Learning",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF101828), // Dark text
                        ),
                      ),
                    ),
                    
                    _buildMenuItem(
                      iconPath: 'assets/user/mental_wellness_icon.png',
                      title: "Mental Wellness Hub",
                      subtitle: "Journaling, mood tracker & AI companion",
                      onTap: () {
                        // Navigate to Mental Wellness Hub page
                      },
                    ),
                    _buildMenuItem(
                      iconPath: 'assets/user/health_awareness_hub.png',
                      title: "Health Awareness Hub",
                      subtitle: "Articles, videos & wellness tips",
                      onTap: () {
                        // Navigate to Health Awareness Hub page
                      },
                    ),
                    
                    // Settings & Support Section Header
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      color: Color(0xFFEBF1FA), // bg1
                      child: Text(
                        "Settings & Support",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF101828), // Dark text
                        ),
                      ),
                    ),
                    
                    _buildMenuItem(
                      iconPath: 'assets/user/settings.png', // Using settings.png as per available asset
                      title: "Settings",
                      subtitle: "App preferences & notifications",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SettingsPage(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      iconPath: 'assets/user/privacy_and_security.png',
                      title: "Privacy & Security",
                      subtitle: "Data protection & permissions",
                      onTap: () {
                        // Navigate to Privacy & Security page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PrivacySecurityPage(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      iconPath: 'assets/user/help_and_support.png',
                      title: "Help & Support",
                      subtitle: "FAQs & contact support",
                      onTap: () {
                        // Navigate to Help & Support page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HelpAndSupportPage(),
                          ),
                        );
                      },
                    ),
                    
                    // Logout Button
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Color(0xFFFFE6E6), // Light red background
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.logout,
                            size: 24,
                            color: Color(0xFFFF6E6E), // r1
                          ),
                        ),
                        title: Text(
                          "Logout",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFFF6E6E), // r1
                          ),
                        ),
                        onTap: () {
                          _showLogoutDialog();
                        },
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
  
  IconData _getIconForPath(String iconPath) {
    if (iconPath.contains('profile_details')) return Icons.person_outline;
    if (iconPath.contains('appointments')) return Icons.calendar_today;
    if (iconPath.contains('prescription')) return Icons.description;
    if (iconPath.contains('medicine_reminder')) return Icons.notifications;
    if (iconPath.contains('medical_vault')) return Icons.folder;
    if (iconPath.contains('mental_wellness')) return Icons.psychology;
    if (iconPath.contains('health_awareness')) return Icons.menu_book;
    if (iconPath.contains('settings')) return Icons.settings;
    if (iconPath.contains('privacy')) return Icons.shield;
    if (iconPath.contains('help')) return Icons.help_outline;
    return Icons.circle; // Default fallback
  }
  
  Widget _buildMenuItem({
    required String iconPath,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Color(0xFFEBF1FA), // bg1
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Icon(
              _getIconForPath(iconPath),
              size: 24,
              color: Color(0xFF174880), // b1
            ),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF101828), // Dark text
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF6A7282), // ge3
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: Color(0xFF99A1AF), // ge1
          size: 24,
        ),
        onTap: onTap,
      ),
    );
  }
  
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Perform logout action
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text("Logout"),
            ),
          ],
        );
      },
    );
  }
  
}