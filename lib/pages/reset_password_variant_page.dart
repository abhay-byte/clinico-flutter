import 'package:flutter/material.dart';

class ResetPasswordVariantPage extends StatefulWidget {
  @override
  _ResetPasswordVariantPageState createState() => _ResetPasswordVariantPageState();
}

class _ResetPasswordVariantPageState extends State<ResetPasswordVariantPage> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
 final _confirmPasswordController = TextEditingController();
  bool _currentPasswordVisible = false;
 bool _newPasswordVisible = false;
 bool _confirmPasswordVisible = false;

  @override
 void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEBF1FA), // bg1
      body: SafeArea(
        child: Column(
          children: [
            // Header Section with curved bottom
            Container(
              width: double.infinity,
              height: 100, // Fixed height for the header
              decoration: BoxDecoration(
                color: Color(0xFF174880), // b1 - Dark blue
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
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
                        "Reset Password",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600, // Semi-bold
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Change your account password",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withValues(alpha: 0.7), // 70% opacity
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Password Reset Card
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
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
                        margin: EdgeInsets.symmetric(vertical: 12),
                        child: Column(
                          children: [
                            // Header
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color(0xFFE5E5E5), // Light grey divider
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Text(
                                "Change Password",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF101828),
                                ),
                              ),
                            ),
                            
                            // Current Password Field
                            Container(
                              margin: EdgeInsets.only(top: 16),
                              child: TextFormField(
                                controller: _currentPasswordController,
                                obscureText: !_currentPasswordVisible,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your current password';
                                  }
                                  if (value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Current Password',
                                  hintText: 'Enter your current password',
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    color: Color(0xFF6A7282),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _currentPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Color(0xFF6A7282),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _currentPasswordVisible = !_currentPasswordVisible;
                                      });
                                    },
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: Color(0xFFE5E5E5)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: Color(0xFFE5E5E5)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Color(0xFF248BEB), // b4 - Blue
                                      width: 2,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ),
                                ),
                              ),
                            ),
                            
                            // New Password Field
                            Container(
                              margin: EdgeInsets.only(top: 16),
                              child: TextFormField(
                                controller: _newPasswordController,
                                obscureText: !_newPasswordVisible,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a new password';
                                  }
                                  if (value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }
                                  if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(value)) {
                                    return 'Password must contain at least one uppercase, lowercase, and number';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'New Password',
                                  hintText: 'Enter your new password',
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Color(0xFF6A7282),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _newPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Color(0xFF6A7282),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _newPasswordVisible = !_newPasswordVisible;
                                      });
                                    },
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: Color(0xFFE5E5)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: Color(0xFFE5E5E5)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Color(0xFF248BEB), // b4 - Blue
                                      width: 2,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ),
                                ),
                              ),
                            ),
                            
                            // Confirm Password Field
                            Container(
                              margin: EdgeInsets.only(top: 16),
                              child: TextFormField(
                                controller: _confirmPasswordController,
                                obscureText: !_confirmPasswordVisible,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please confirm your new password';
                                  }
                                  if (value != _newPasswordController.text) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Confirm New Password',
                                  hintText: 'Re-enter your new password',
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    color: Color(0xFF6A7282),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _confirmPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Color(0xFF6A7282),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _confirmPasswordVisible = !_confirmPasswordVisible;
                                      });
                                    },
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: Color(0xFFE5E5E5)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: Color(0xFFE5E5E5)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Color(0xFF248BEB), // b4 - Blue
                                      width: 2,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Password Requirements Card
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFFEBF1FA), // Light grey-blue background
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.symmetric(vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Password Requirements",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF101828),
                              ),
                            ),
                            SizedBox(height: 12),
                            
                            // Requirements List
                            _buildRequirement("At least 6 characters long"),
                            SizedBox(height: 8),
                            _buildRequirement("Contains at least one uppercase letter (A-Z)"),
                            SizedBox(height: 8),
                            _buildRequirement("Contains at least one lowercase letter (a-z)"),
                            SizedBox(height: 8),
                            _buildRequirement("Contains at least one number (0-9)"),
                            SizedBox(height: 8),
                            _buildRequirement("Contains at least one special character (!@#\$%)"),
                          ],
                        ),
                      ),
                      
                      // Reset Password Button
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFF248BEB), // Bright blue
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
                        margin: EdgeInsets.symmetric(vertical: 16),
                        child: TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Password reset logic would go here
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Password reset successfully!"),
                                  backgroundColor: Color(0xFF248BEB),
                                ),
                              );
                              // Navigate back after successful reset
                              Navigator.of(context).pop();
                            }
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            "Reset Password",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      
                      // Cancel Button
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Color(0xFFE5E5E5)),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF101828),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
 }
  
  // Helper method to build requirement items
  Widget _buildRequirement(String text) {
    return Row(
      children: [
        Icon(
          Icons.check_circle,
          color: Color(0xFF00CC44), // Green
          size: 18,
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF101828), // Dark text
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}