import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpAndSupportPage extends StatefulWidget {
  const HelpAndSupportPage({Key? key}) : super(key: key);

  @override
  State<HelpAndSupportPage> createState() => _HelpAndSupportPageState();
}

class _HelpAndSupportPageState extends State<HelpAndSupportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBF1FA), // bg1 - Light blue background
      body: SafeArea(
        child: Column(
          children: [
            // Top Section - Header Bar
            Container(
              height: 100,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF174880), // b1 - Dark blue
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back Button
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: 44,
                        height: 44,
                        padding: const EdgeInsets.all(8.0),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Title and Subtitle
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Help & Support",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "We're here to help",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Section 1: Frequently Asked Questions
                    Container(
                      color: const Color(0xFFEBF1FA), // bg1 - Light
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0), // Increased vertical padding
                      child: const Text(
                        "Frequently Asked Questions",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF101828), // Dark text
                        ),
                      ),
                    ),
                    
                    // FAQs Card
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // Increased vertical margin
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: Container(
                          width: 48,
                          height: 48,
                          decoration: const BoxDecoration(
                            color: Color(0xFFEBF1FA), // bg1 - Light blue
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.help_outline,
                            color: Color(0xFF174880), // b1 - Dark blue
                            size: 24,
                          ),
                        ),
                        title: const Text(
                          "FAQs",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF101828), // Dark text
                          ),
                        ),
                        subtitle: const Text(
                          "Common questions about using Clinico",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF6A7282), // ge3 - Grey
                            height: 1.3,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.chevron_right,
                          color: Color(0xFF99A1AF), // ge1 - Grey
                          size: 24,
                        ),
                        onTap: () {
                          // Navigate to FAQs list page
                          // For now, just showing a snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Navigate to FAQs page")),
                          );
                        },
                      ),
                    ),
                    
                    // Section 2: Connect With Us
                    Container(
                      color: const Color(0xFFEBF1FA), // bg1 - Light
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0), // Increased vertical padding
                      child: const Text(
                        "Connect With Us",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF101828), // Dark text
                        ),
                      ),
                    ),
                    
                    // Email Support Card
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // Increased vertical margin
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          ListTile(
                            leading: Container(
                              width: 48,
                              height: 48,
                              decoration: const BoxDecoration(
                                color: Color(0xFFE5F3FF), // Light blue
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.email_outlined,
                                color: Color(0xFF248BEB), // b4 - Blue
                                size: 24,
                              ),
                            ),
                            title: const Text(
                              "Email Support",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF101828), // Dark text
                              ),
                            ),
                            subtitle: const Text(
                              "Get help via email • support@clinico.org",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF6A7282), // ge3 - Grey
                              ),
                            ),
                            onTap: () {
                              _launchEmail();
                            },
                          ),
                          Positioned(
                            top: 16,
                            right: 16,
                            child: Icon(
                              Icons.open_in_new,
                              size: 20,
                              color: const Color(0xFF99A1AF), // ge1 - Grey
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Official Website Card
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // Increased vertical margin
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          ListTile(
                            leading: Container(
                              width: 48,
                              height: 48,
                              decoration: const BoxDecoration(
                                color: Color(0xFFF3E5FF), // Light purple
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.language,
                                color: Color(0xFF9C27B0), // Purple
                                size: 24,
                              ),
                            ),
                            title: const Text(
                              "Official Website",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF101828), // Dark text
                              ),
                            ),
                            subtitle: const Text(
                              "Visit our website for resources",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF6A7282), // ge3 - Grey
                              ),
                            ),
                            onTap: () {
                              _launchWebsite();
                            },
                          ),
                          Positioned(
                            top: 16,
                            right: 16,
                            child: Icon(
                              Icons.open_in_new,
                              size: 20,
                              color: const Color(0xFF99A1AF), // ge1 - Grey
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Section 3: Follow Us on Social Media
                    Container(
                      color: const Color(0xFFEBF1FA), // bg1 - Light
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0), // Increased vertical padding
                      child: const Text(
                        "Follow Us on Social Media",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF101828), // Dark text
                        ),
                      ),
                    ),
                    
                    // Social Media Card Container
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // Increased vertical margin
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Instagram Item
                          _buildSocialMediaItem(
                            icon: Icons.camera_alt,
                            iconColor: const Color(0xFFE91E63), // Pink/Magenta
                            iconBackgroundColor: const Color(0xFFFFE5F0), // Light pink
                            title: "Instagram",
                            handle: "@clinico",
                            onTap: () {
                              _launchInstagram();
                            },
                          ),
                          const Divider(height: 1, indent: 16, endIndent: 16),
                          
                          // X (Twitter) Item
                          _buildSocialMediaItem(
                            icon: Icons.tag, // Placeholder for Twitter/X icon
                            iconColor: const Color(0xFF1DA1F2), // Twitter Blue
                            iconBackgroundColor: const Color(0xFFE8F5FD), // Light grey-blue
                            title: "X (Twitter)",
                            handle: "@clinico",
                            onTap: () {
                              _launchTwitter();
                            },
                          ),
                          const Divider(height: 1, indent: 16, endIndent: 16),
                          
                          // Facebook Item
                          _buildSocialMediaItem(
                            icon: Icons.facebook,
                            iconColor: const Color(0xFF1877F2), // Facebook Blue
                            iconBackgroundColor: const Color(0xFFE5F3FF), // Light blue
                            title: "Facebook",
                            handle: "@clinico",
                            onTap: () {
                              _launchFacebook();
                            },
                          ),
                        ],
                      ),
                    ),
                    
                    // Contact Support Team Button
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0), // Increased vertical margin
                      decoration: BoxDecoration(
                        color: const Color(0xFF248BEB), // b4 - Bright blue
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: const Icon(
                          Icons.phone, // or Icons.support_agent
                          color: Colors.white,
                          size: 24,
                        ),
                        title: const Text(
                          "Contact Support Team",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          "Chat or call Clinico support",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                        trailing: const Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                          size: 24,
                        ),
                        onTap: () {
                          // Navigate to contact support page or open contact options
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Navigate to contact support page")),
                          );
                        },
                      ),
                    ),
                    
                    // Section 4: Popular Help Topics
                    Container(
                      color: const Color(0xFFEBF1FA), // bg1 - Light
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0), // Increased vertical padding
                      child: const Text(
                        "Popular Help Topics",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF101828), // Dark text
                        ),
                      ),
                    ),
                    
                    // Help Topics Card
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // Increased vertical margin
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildHelpTopicItem(
                            "How to book an appointment",
                            () {
                              // Navigate to help article
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Navigate to 'How to book an appointment' help article")),
                              );
                            },
                          ),
                          const Divider(height: 1, indent: 16, endIndent: 16),
                          _buildHelpTopicItem(
                            "Managing prescriptions",
                            () {
                              // Navigate to help article
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Navigate to 'Managing prescriptions' help article")),
                              );
                            },
                          ),
                          const Divider(height: 1, indent: 16, endIndent: 16),
                          _buildHelpTopicItem(
                            "Understanding medical reports",
                            () {
                              // Navigate to help article
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Navigate to 'Understanding medical reports' help article")),
                              );
                            },
                          ),
                          const Divider(height: 1, indent: 16, endIndent: 16),
                          _buildHelpTopicItem(
                            "Setting medication reminders",
                            () {
                              // Navigate to help article
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Navigate to 'Setting medication reminders' help article")),
                              );
                            },
                          ),
                          const Divider(height: 1, indent: 16, endIndent: 16),
                          _buildHelpTopicItem(
                            "Uploading medical documents",
                            () {
                              // Navigate to help article
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Navigate to 'Uploading medical documents' help article")),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    
                    // Section 5: Support Hours
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0), // Increased vertical margin
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEBF1FA), // bg1 - Light blue
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(color: const Color(0xFFE0E0E0)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.access_time, // or Icons.schedule
                            size: 24,
                            color: const Color(0xFF174880), // b1 - Dark blue
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            "Support Hours",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF101828), // Dark text
                            ),
                          ),
                          const SizedBox(height: 12), // Increased spacing
                          const Text(
                            "Monday - Friday: 9:00 AM - 6:00 PM",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF101828), // Dark text
                            ),
                          ),
                          const SizedBox(height: 8), // Increased spacing
                          const Text(
                            "Saturday: 10:00 AM - 4:00 PM",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF101828), // Dark text
                            ),
                          ),
                          const SizedBox(height: 8), // Increased spacing
                          const Text(
                            "Sunday: Closed",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF101828), // Dark text
                            ),
                          ),
                          const SizedBox(height: 16), // Increased spacing
                          const Text(
                            "Emergency support available 24/7 via email",
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF6A7282), // ge3 - Grey
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Footer: App Version
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20.0), // Increased vertical padding
                      child: const Text(
                        "Clinico App v1.0.0",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF99A1AF), // ge1 - Light grey
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
  
  // Helper method to build social media items
  Widget _buildSocialMediaItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBackgroundColor,
    required String title,
    required String handle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: iconBackgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: 24,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xFF101828), // Dark text
        ),
      ),
      subtitle: Text(
        handle,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFF6A7282), // ge3 - Grey
          height: 1.3,
        ),
      ),
      trailing: Icon(
        Icons.open_in_new,
        size: 20,
        color: const Color(0xFF99A1AF), // ge1 - Grey
      ),
      onTap: onTap,
    );
  }
  
  // Helper method to build help topic items
  Widget _buildHelpTopicItem(String title, VoidCallback onTap) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      leading: Icon(
        Icons.chat_bubble_outline,
        size: 20,
        color: const Color(0xFF248BEB), // b4 - Bright blue
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          color: Color(0xFF101828), // Dark text
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        size: 20,
        color: const Color(0xFFCCCCCC), // Grey
      ),
      onTap: onTap,
    );
  }
  
  // Methods to launch external URLs
  void _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@clinico.org',
      query: 'subject=Help Request',
    );
    
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not launch email client")),
      );
    }
  }
  
  void _launchWebsite() async {
    final Uri websiteUri = Uri.parse('https://clinico.org');
    
    if (await canLaunchUrl(websiteUri)) {
      await launchUrl(websiteUri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not launch website")),
      );
    }
  }
  
  void _launchInstagram() async {
    final Uri instagramUri = Uri.parse('https://instagram.com/clinico');
    
    if (await canLaunchUrl(instagramUri)) {
      await launchUrl(instagramUri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not launch Instagram")),
      );
    }
  }
  
  void _launchTwitter() async {
    final Uri twitterUri = Uri.parse('https://twitter.com/clinico');
    
    if (await canLaunchUrl(twitterUri)) {
      await launchUrl(twitterUri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not launch Twitter")),
      );
    }
  }
  
  void _launchFacebook() async {
    final Uri facebookUri = Uri.parse('https://facebook.com/clinico');
    
    if (await canLaunchUrl(facebookUri)) {
      await launchUrl(facebookUri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not launch Facebook")),
      );
    }
  }
}