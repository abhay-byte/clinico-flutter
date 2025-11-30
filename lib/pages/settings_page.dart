import 'package:flutter/material.dart';
import 'notification_settings_page.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _showDeleteDialog = false;
  String _password = '';
  bool _passwordVisible = false;
  bool _isConfirmed = false;
  
  bool get isDeleteButtonEnabled {
    return _password.isNotEmpty && _isConfirmed;
  }
  
  void _handleDeleteAccount() {
    // Handle delete account confirmation
    // For now, just close the dialog and show a snackbar
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Account deletion would happen here"),
        backgroundColor: Color(0xFFD32F2F),
      ),
    );
    setState(() {
      _showDeleteDialog = false;
      _password = '';
      _isConfirmed = false;
    });
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
                            "Settings",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Manage your account",
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
                
                // Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // Account Settings Section
                        _buildSettingsMenuItem(
                          context,
                          icon: Icons.lock_outline,
                          iconBackgroundColor: Color(0xFFE3F2FD),
                          title: "Reset Password",
                          subtitle: "Change your current login",
                          onTap: () {
                            // Navigate to reset password screen
                          },
                        ),
                        _buildSettingsMenuItem(
                          context,
                          icon: Icons.notifications_outlined,
                          iconBackgroundColor: Color(0xFFFFF3E0),
                          title: "Notification Settings",
                          subtitle: "Manage all alerts and sounds",
                          onTap: () {
                            // Navigate to notification settings screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NotificationSettingsPage(),
                              ),
                            );
                          },
                        ),
                        _buildSettingsMenuItem(
                          context,
                          icon: Icons.language_outlined,
                          iconBackgroundColor: Color(0xFFE8F5E9),
                          title: "Language Preferences",
                          subtitle: "Choose app language",
                          onTap: () {
                            // Navigate to language preferences screen
                          },
                        ),
                        _buildSettingsMenuItem(
                          context,
                          icon: Icons.delete_outline,
                          iconBackgroundColor: Color(0xFFFFEBEE),
                          title: "Delete Account",
                          titleColor: Color(0xFFD32F2F),
                          subtitle: "Permanently remove your",
                          chevronColor: Color(0xFFD32F2F),
                          onTap: () {
                            setState(() {
                              _showDeleteDialog = true;
                            });
                          },
                        ),
                        
                        SizedBox(height: 24),
                        
                        // Help & Support Section Header
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Help & Support",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF6A7282),
                            ),
                          ),
                        ),
                        
                        _buildSettingsMenuItem(
                          context,
                          icon: Icons.help_outline,
                          iconBackgroundColor: Color(0xFFE3F2FD),
                          title: "Help Center",
                          subtitle: "FAQs, guides, and tutorials",
                          onTap: () {
                            // Navigate to help center screen
                          },
                        ),
                        
                        SizedBox(height: 16),
                        
                        // Contact Us Card
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withValues(alpha: 0.1),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Contact Us",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF101828),
                                  ),
                                ),
                                SizedBox(height: 16),
                                
                                // Phone Support
                                Row(
                                  children: [
                                    Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFE3F2FD),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.phone,
                                        size: 24,
                                        color: Color(0xFF1976D2),
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Phone Support",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF6A7282),
                                            ),
                                          ),
                                          Text(
                                            "+1 (800) 123-4567",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF101828),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                
                                // Email Support
                                Row(
                                  children: [
                                    Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFE3F2FD),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.email_outlined,
                                        size: 24,
                                        color: Color(0xFF1976D2),
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Email Support",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF6A7282),
                                            ),
                                          ),
                                          Text(
                                            "support@clinico.com",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF101828),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        
                        SizedBox(height: 16),
                        
                        // Privacy Notice Card
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xFFF5F9FF),
                            border: Border.all(
                              color: Color(0xFFBBDEFB),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFE3F2FD),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.shield_outlined,
                                    size: 24,
                                    color: Color(0xFF1976D2),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Your Privacy Matters",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF101828),
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "We take your privacy seriously. All your data is encrypted and stored securely. Read our Privacy Policy.",
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
                          ),
                        ),
                        
                        SizedBox(height: 24),
                        
                        // App Version Footer
                        Column(
                          children: [
                            Text(
                              "Clinico App Version",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF6A7282),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "v0.0.1",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF6A7282),
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Delete Account Dialog
            if (_showDeleteDialog) ...[
              // Background tint
              Container(
                color: Colors.black.withValues(alpha: 0.5),
              ),
              _buildDeleteAccountDialog(),
            ],
          ],
        ),
      ),
    );
  }
  
  Widget _buildDeleteAccountDialog() {
    return Dialog(
      insetPadding: EdgeInsets.all(20),
      backgroundColor: Colors.white, // Ensure pure white background
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24), // Rounded corners for the dialog
      ),
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white, // Pure white background
          borderRadius: BorderRadius.circular(24), // Ensure rounded corners
        ),
        child: SingleChildScrollView(  // Make the dialog scrollable to handle keyboard
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Close button
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.close, color: Colors.grey),
                  onPressed: () {
                    setState(() {
                      _showDeleteDialog = false;
                    });
                  },
                ),
              ),
              
              // Warning Icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Color(0xFFFFE5E5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Icons.warning,
                  color: Color(0xFFD32F2F),
                  size: 64,
                ),
              ),
              
              SizedBox(height: 24),
              
              // Title
              Text(
                "Delete Account",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF101828),
                ),
              ),
              
              SizedBox(height: 16),
              
              // Description
              Text(
                "Deleting your account will permanently remove all your data, including medical records and prescriptions. This action cannot be undone.",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF616161),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              
              SizedBox(height: 24),
              
              // Password Input
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enter Password",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF101828),
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      obscureText: !_passwordVisible,
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Enter your password",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.lock_outline, color: Colors.grey),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 16),
              
              // Confirmation Checkbox
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFFFF5F5),
                  border: Border.all(color: Color(0xFFFFCDD2)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Checkbox(
                      value: _isConfirmed,
                      activeColor: Color(0xFFD32F2F),
                      onChanged: (bool? value) {
                        setState(() {
                          _isConfirmed = value ?? false;
                        });
                      },
                    ),
                    Expanded(
                      child: Text(
                        "I confirm I want to delete my account and understand that all my data will be permanently removed.",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF101828),
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 24),
              
              // Delete Button
              ElevatedButton(
                onPressed: isDeleteButtonEnabled ? _handleDeleteAccount : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFEF5350),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  fixedSize: Size(double.infinity, 56),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.delete_outline),
                    SizedBox(width: 8),
                    Text(
                      "Delete Account",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 12),
              
              // Cancel Button
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    _showDeleteDialog = false;
                    _password = '';
                    _isConfirmed = false;
                  });
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Color(0xFFE0E0)),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.grey,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  fixedSize: Size(double.infinity, 56),
                ),
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildSettingsMenuItem(
    BuildContext context, {
    required IconData icon,
    required Color iconBackgroundColor,
    required String title,
    required String subtitle,
    Color? titleColor,
    Color? chevronColor,
    required VoidCallback onTap,
  }) {
    Color actualTitleColor = titleColor ?? Color(0xFF101828);
    Color actualChevronColor = chevronColor ?? Color(0xFF99A1AF);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 1),
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
            color: actualTitleColor.withValues(alpha: 0.7),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: actualTitleColor,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF6A7282),
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: actualChevronColor,
          size: 24,
        ),
        onTap: onTap,
      ),
    );
  }
}