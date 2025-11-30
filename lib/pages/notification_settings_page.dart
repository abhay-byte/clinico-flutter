import 'package:flutter/material.dart';

class NotificationSettingsPage extends StatefulWidget {
  @override
  _NotificationSettingsPageState createState() => _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  // State variables for all notification toggles
  bool _allNotifications = true;
  bool _appointmentAlerts = true;
  bool _incomingCalls = true;
  bool _incomingVideoCalls = true;
  bool _medicalReminders = true;
  bool _vibrationAlerts = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEBF1FA), // Light blue-grey background
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              height: 110, // Fixed height for the header
              decoration: BoxDecoration(
                color: Color(0xFF174880), // Dark blue background (#174880 or b1)
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
                        "Notification Settings",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600, // Semi-bold
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Manage alerts and sounds",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withAlpha((255 * 0.7).toInt()), // 70% opacity
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
                    // Master Toggle Card - All Notifications
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
                      child: Row(
                        children: [
                          // Icon Section (Left)
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: Color(0xFFEBF1FA), // Light blue background (#EBF1FA or bg1)
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.notifications,
                              size: 28,
                              color: Color(0xFF174880), // Dark blue color (#174880 or b1)
                            ),
                          ),
                          SizedBox(width: 12),
                          
                          // Text Section (Center)
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "All Notifications",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600, // Semi-bold
                                    color: Color(0xFF101828), // Dark text (#101828)
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Master toggle to enable or disable all alerts",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF6A7282), // Grey (#6A7282 or ge3)
                                    height: 1.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Toggle Switch (Right)
                          Switch(
                            value: _allNotifications,
                            activeColor: Color(0xFF00CC44), // Green (#00CC44 or similar)
                            activeTrackColor: Color(0xFFC8E6C9), // Light green
                            inactiveThumbColor: Color(0xFF9E9E9E), // Grey
                            inactiveTrackColor: Color(0xFFE0E0E0), // Light grey
                            onChanged: (bool value) {
                              setState(() {
                                _allNotifications = value;
                                // When master toggle is OFF, turn OFF all individual toggles
                                if (!value) {
                                  _appointmentAlerts = false;
                                  _incomingCalls = false;
                                  _incomingVideoCalls = false;
                                  _medicalReminders = false;
                                  _vibrationAlerts = false;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    
                    // Divider Text
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Text(
                        "Below Are Individual Notification Controls",
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF99A1AF), // Medium grey (#99A1AF or ge1)
                        ),
                      ),
                    ),
                    
                    // Individual Notification Cards
                    _buildNotificationCard(
                      icon: Icons.calendar_today,
                      iconBackgroundColor: Color(0xFFE5F3FF), // Light blue (#E5F3FF)
                      iconColor: Color(0xFF248BEB), // Blue (#248BEB or b4)
                      title: "Appointment Alerts",
                      description: "Receive updates for upcoming consultations",
                      value: _appointmentAlerts,
                      onChanged: (bool value) {
                        if (_allNotifications) {
                          setState(() {
                            _appointmentAlerts = value;
                          });
                        }
                      },
                    ),
                    
                    _buildNotificationCard(
                      icon: Icons.phone,
                      iconBackgroundColor: Color(0xFFE8FFE5), // Light green (#E8FFE5)
                      iconColor: Color(0xFF00CC44), // Green (#00CC44 or similar)
                      title: "Incoming Calls",
                      description: "Notifications for incoming audio calls",
                      value: _incomingCalls,
                      onChanged: (bool value) {
                        if (_allNotifications) {
                          setState(() {
                            _incomingCalls = value;
                          });
                        }
                      },
                    ),
                    
                    _buildNotificationCard(
                      icon: Icons.videocam,
                      iconBackgroundColor: Color(0xFFFFE5F0), // Light pink (#FFE5F0)
                      iconColor: Color(0xFFE91E63), // Pink/Magenta (#E91E63 or similar)
                      title: "Incoming Video Calls",
                      description: "Notifications for incoming video consultations",
                      value: _incomingVideoCalls,
                      onChanged: (bool value) {
                        if (_allNotifications) {
                          setState(() {
                            _incomingVideoCalls = value;
                          });
                        }
                      },
                    ),
                    
                    _buildNotificationCard(
                      icon: Icons.medication, // or Icons.local_pharmacy
                      iconBackgroundColor: Color(0xFFFFF9E5), // Light yellow/cream (#FFF9E5)
                      iconColor: Color(0xFFFFA726), // Orange/Amber (#FFA726)
                      title: "Medical Reminders",
                      description: "Daily medication reminder alerts",
                      value: _medicalReminders,
                      onChanged: (bool value) {
                        if (_allNotifications) {
                          setState(() {
                            _medicalReminders = value;
                          });
                        }
                      },
                    ),
                    
                    _buildNotificationCard(
                      icon: Icons.vibration,
                      iconBackgroundColor: Color(0xFFF3E5FF), // Light purple (#F3E5FF)
                      iconColor: Color(0xFF9C27B0), // Purple (#9C27B0)
                      title: "Vibration Alerts",
                      description: "Enable vibration for all alerts",
                      value: _vibrationAlerts,
                      onChanged: (bool value) {
                        if (_allNotifications) {
                          setState(() {
                            _vibrationAlerts = value;
                          });
                        }
                      },
                    ),
                    
                    // Multi-Device Sync Info Card
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
                      child: Row(
                        children: [
                          // Icon Section (Left)
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: Color(0xFFEBF1FA), // Light blue background (#EBF1FA or bg1)
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.info_outline,
                              size: 28,
                              color: Color(0xFF174880), // Dark blue color (#174880 or b1)
                            ),
                          ),
                          SizedBox(width: 12),
                          
                          // Text Section (Right)
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Multi-Device Sync",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600, // Semi-bold
                                    color: Color(0xFF101828), // Dark text (#101828)
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  "Notification settings apply to all devices logged into your account. Changes will sync automatically across your phone, tablet, and web browser.",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF6A7282), // Grey (#6A7282 or ge3)
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Notification Behavior Section
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFEBF1FA), // Light grey-blue (#EBF1FA or bg1)
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Notification Behavior",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600, // Semi-bold
                              color: Color(0xFF101828), // Dark text (#101828)
                            ),
                          ),
                          SizedBox(height: 12),
                          
                          // Bullet Points
                          _buildBulletPoint("Sound alerts will play at your device's current volume level"),
                          SizedBox(height: 12),
                          _buildBulletPoint("Vibration works independently of sound settings"),
                          SizedBox(height: 12),
                          _buildBulletPoint("Critical alerts may override 'Do Not Disturb' mode"),
                        ],
                      ),
                    ),
                    
                    // Send Test Notification Button
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFF248BEB), // Bright blue (#248BEB or b4)
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
                          // Trigger a test notification to device
                          _showTestNotification();
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.notifications_active,
                              size: 20,
                              color: Colors.white,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Send Test Notification",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600, // Semi-bold
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
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
  
  // Helper method to build individual notification cards
  Widget _buildNotificationCard({
    required IconData icon,
    required Color iconBackgroundColor,
    required Color iconColor,
    required String title,
    required String description,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
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
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Icon Section (Left)
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: iconBackgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 28,
              color: iconColor,
            ),
          ),
          SizedBox(width: 12),
          
          // Text Section (Center)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600, // Semi-bold
                    color: Color(0xFF101828), // Dark text (#101828)
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6A7282), // Grey (#6A7282 or ge3)
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          
          // Toggle Switch (Right)
          Switch(
            value: value,
            activeColor: Color(0xFF00CC44), // Green (#00CC44)
            activeTrackColor: Color(0xFFC8E6C9), // Light green
            inactiveThumbColor: Color(0xFF9E9E9E), // Grey
            inactiveTrackColor: Color(0xFFE0E0E0), // Light grey
            onChanged: _allNotifications ? onChanged : null, // Disable if master toggle is OFF
          ),
        ],
      ),
    );
  }
  
  // Helper method to build bullet points
  Widget _buildBulletPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "■", // Small square bullet
          style: TextStyle(
            fontSize: 6,
            color: Color(0xFF174880), // Dark blue (#174880 or b1)
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF101828), // Dark text (#101828)
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
  
  // Method to show test notification
  void _showTestNotification() {
    // Show a snackbar to simulate sending a test notification
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Test notification sent!"),
        backgroundColor: Color(0xFF248BEB), // Bright blue (#248BEB or b4)
      ),
    );
  }
}