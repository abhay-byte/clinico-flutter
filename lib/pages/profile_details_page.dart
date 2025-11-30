import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileDetailsPage extends StatefulWidget {
  const ProfileDetailsPage({super.key});

  @override
  State<ProfileDetailsPage> createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<ProfileDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light, // For light status bar icons
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F7FA), // Background color
        body: SafeArea(
          child: Column(
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
                          "Profile Details",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Your health profile",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                    Spacer(), // Push edit button to the right
                    // Edit Button
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 24,
                      ),
                      onPressed: () {
                        // Add edit functionality here
                      },
                    ),
                  ],
                ),
              ),
              // Main Content - using Expanded to fill remaining space
              Expanded(
                child: Stack(
                  children: [
                    // Background that extends under the header
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEBF1FA), // Same background color
                      ),
                    ),
                    // Scrollable content with reduced padding
                    SingleChildScrollView(
                      padding: const EdgeInsets.only(top: 20), // Reduced top padding
                      child: Column(
                        children: [
                          // Profile Card Section - appears to overlap by starting higher
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                // Profile Avatar
                                Container(
                                  margin: const EdgeInsets.only(top: 30), // Increased margin
                                  width: 140, // Increased size
                                  height: 140, // Increased size
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF174880), // Dark blue background
                                    borderRadius: BorderRadius.circular(20), // More rounded
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      const Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 80, // Larger icon
                                      ),
                                      // Camera Badge
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                          width: 40, // Larger badge
                                          height: 40, // Larger badge
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF248BEB), // Light blue
                                            borderRadius: BorderRadius.circular(20), // Circular
                                          ),
                                          child: const Icon(
                                            Icons.camera_alt,
                                            color: Colors.white,
                                            size: 18, // Larger icon
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // User Name & ID
                                Container(
                                  margin: const EdgeInsets.only(top: 16), // Increased margin
                                  child: const Column(
                                    children: [
                                      Text(
                                        "Lorem Ipsum Dolor",
                                        style: TextStyle(
                                          fontSize: 20, // Larger font
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF101828),
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "CLN-10234",
                                        style: TextStyle(
                                          fontSize: 16, // Larger font
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF248BEB),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Account Type & Member Since
                                Container(
                                  margin: const EdgeInsets.only(top: 20), // Increased margin
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 16),
                                          child: Column(
                                            children: [
                                              Text(
                                                "Account Type",
                                                style: TextStyle(
                                                  fontSize: 14, // Larger font
                                                  fontWeight: FontWeight.w400,
                                                  color: const Color(0xFF6A7282),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(top: 4),
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                  vertical: 4, // Increased padding
                                                ),
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFFE1FFBF), // Light green
                                                  borderRadius: BorderRadius.circular(8), // More rounded
                                                ),
                                                child: const Text(
                                                  "Patient",
                                                  style: TextStyle(
                                                    fontSize: 14, // Larger font
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFF00CC44), // Dark green
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 1,
                                        height: 45, // Increased height
                                        color: const Color(0xFFE5E5E5), // Light grey
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 16),
                                          child: Column(
                                            children: [
                                              Text(
                                                "Member Since",
                                                style: TextStyle(
                                                  fontSize: 14, // Larger font
                                                  fontWeight: FontWeight.w400,
                                                  color: const Color(0xFF6A7282),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(top: 4),
                                                child: const Text(
                                                  "Jan 2025",
                                                  style: TextStyle(
                                                    fontSize: 16, // Larger font
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFF101828),
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
                                // Additional info section
                                Container(
                                  margin: const EdgeInsets.symmetric(vertical: 20), // Add vertical space
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // Gender
                                      Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFEBF1FA), // Light blue background
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: const Icon(
                                              Icons.male,
                                              color: Color(0xFF174880),
                                              size: 24,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          const Text(
                                            "Male",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF101828),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // Age
                                      Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFEBF1FA), // Light blue background
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: const Icon(
                                              Icons.cake,
                                              color: Color(0xFF174880),
                                              size: 24,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          const Text(
                                            "30 yrs",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF101828),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // Blood Group
                                      Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFEBF1FA), // Light blue background
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Icon(
                                              Icons.bloodtype,
                                              color: const Color(0xFF174880),
                                              size: 24,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          const Text(
                                            "B+",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF101828),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // Location
                                      Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFEBF1FA), // Light blue background
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: const Icon(
                                              Icons.location_on,
                                              color: Color(0xFF174880),
                                              size: 24,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          const Text(
                                            "Chennai",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF101828),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Personal Information Section
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Section Header
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFEBF1FA), // Light blue background
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.person,
                                        color: const Color(0xFF174880),
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      const Text(
                                        "Personal Information",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF101828),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Information Cards Container
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 8),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.05),
                                        blurRadius: 2,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      // Row 1: Full Name
                                      _buildInfoRow("Full Name", "Lorem Ipsum Dolor"),
                                      // Row 2: Gender
                                      _buildInfoRow("Gender", "Male"),
                                      // Row 3: Date of Birth
                                      _buildInfoRow("Date of Birth", "12 Mar 1995"),
                                      // Row 4: Age
                                      _buildInfoRow("Age", "30 years"),
                                      // Row 5: Blood Group
                                      _buildBloodGroupRow(),
                                      // Row 6: Marital Status
                                      _buildInfoRow("Marital Status", "Single"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Contact Information Section
                          Container(
                            margin: const EdgeInsets.only(top: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Section Header
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFEBF1FA), // Light blue background
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        color: const Color(0xFF174880),
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      const Text(
                                        "Contact Information",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF101828),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Phone Number Card
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.05),
                                        blurRadius: 2,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 44,
                                        height: 44,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFEBF1FA), // Light blue background
                                          borderRadius: BorderRadius.circular(22),
                                        ),
                                        child: Icon(
                                          Icons.phone,
                                          color: const Color(0xFF174880),
                                          size: 24,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Phone Number",
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                color: const Color(0xFF6A7282),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(top: 4),
                                              child: const Text(
                                                "+91 9876543210",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFF101828),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Email Address Card
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.05),
                                        blurRadius: 2,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 44,
                                        height: 44,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFEBF1FA), // Light blue background
                                          borderRadius: BorderRadius.circular(22),
                                        ),
                                        child: Icon(
                                          Icons.email,
                                          color: const Color(0xFF174880),
                                          size: 24,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Email Address",
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                color: const Color(0xFF6A7282),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(top: 4),
                                              child: const Text(
                                                "lorem.ipsum@email.com",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFF101828),
                                                ),
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
                          // Mascot Banner
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            padding: const EdgeInsets.all(20),
                            height: 150,
                            decoration: BoxDecoration(
                              color: const Color(0xFF174880), // Dark blue background
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                // Text Section
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Meet Elphie!",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "Your health companion",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white.withValues(alpha: 0.8),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Mascot Image
                                SizedBox(
                                  width: 110,
                                  child: Image.asset(
                                    'assets/user/user_details/mascot_robot.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Health Information Section
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Section Header
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFEBF1FA), // Light blue background
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.favorite,
                                        color: const Color(0xFF174880),
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      const Text(
                                        "Health Information",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF101828),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Known Allergies Card
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 44,
                                        height: 44,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFFE5E5), // Light red background
                                          borderRadius: BorderRadius.circular(22),
                                        ),
                                        child: Icon(
                                          Icons.warning,
                                          color: Colors.red,
                                          size: 24,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Known Allergies",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF101828),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(top: 4),
                                              child: const Text(
                                                "Penicillin, Sulfa drugs",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xFF6A7282),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Chronic Conditions Card
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 44,
                                        height: 44,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFFF9E5), // Light yellow background
                                          borderRadius: BorderRadius.circular(22),
                                        ),
                                        child: Icon(
                                          Icons.medical_services,
                                          color: Colors.orange,
                                          size: 24,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Chronic Conditions",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF101828),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(top: 4),
                                              child: const Text(
                                                "Hypertension",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xFF6A7282),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Current Medications Card
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 44,
                                        height: 44,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE5F3FF), // Light blue background
                                          borderRadius: BorderRadius.circular(22),
                                        ),
                                        child: Icon(
                                          Icons.medication,
                                          color: const Color(0xFF248BEB),
                                          size: 24,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Current Medications",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF101828),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(top: 4),
                                              child: const Text(
                                                "Amlodipine 5mg (daily)",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xFF6A7282),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Lifestyle Notes Card
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 44,
                                        height: 44,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE8FFE5), // Light green background
                                          borderRadius: BorderRadius.circular(22),
                                        ),
                                        child: Icon(
                                          Icons.favorite,
                                          color: Colors.green,
                                          size: 24,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Lifestyle Notes",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF101828),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(top: 4),
                                              child: const Text(
                                                "Non-smoker, Exercises 3x/week",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xFF6A7282),
                                                ),
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
                          // Data Security Banner
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5F7FA), // Light grey-blue
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: const Color(0xFFE5E5E5)),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.shield,
                                  color: const Color(0xFF6A7282),
                                  size: 24,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Your Data is Secure",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF101828),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 4),
                                        child: Text(
                                          "Your health information is encrypted and protected. Only authorized healthcare providers can access it with your consent.",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xFF6A7282),
                                            height: 1.4,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Bottom Action Button
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF248BEB), // Bright blue
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF248BEB).withValues(alpha: 0.3),
                                  blurRadius: 3,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  "Edit Profile Information",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE5E5E5), // Light grey divider
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF6A7282), // Grey text
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF101828), // Dark text
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBloodGroupRow() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE5E5E5), // Light grey divider
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Blood Group",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF6A7282), // Grey text
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.bloodtype,
                color: const Color(0xFF174880),
                size: 16,
              ),
              const SizedBox(width: 4),
              const Text(
                "B+",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF101828), // Dark text
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}