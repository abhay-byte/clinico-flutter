import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'book_appointment_screen.dart';

class DoctorProfileScreen extends StatelessWidget {
  final String doctorName;
  final String specialty;
  // final String hospital;
  final double rating;
  final double distance;
  final bool isMale;

  const DoctorProfileScreen({
    super.key,
    required this.doctorName,
    required this.specialty,
    // required this.hospital,
    required this.rating,
    required this.distance,
    required this.isMale,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg1,
      appBar: AppBar(
        backgroundColor: AppColors.bg1,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset(
            'assets/book_appointment/back.png',
            width: 24,
            height: 24,
            color: AppColors.ge1,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Doctor Profile',
          style: TextStyle(
            color: AppColors.ge1,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Doctor Header Section
            Container(
              color: AppColors.white,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Doctor Image and Basic Info
                  Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: AppColors.b3,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: isMale
                              ? Image.asset(
                                  'assets/doctor_profile/doctor_male.png',
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.contain,
                                )
                              : Image.asset(
                                  'assets/doctor_profile/doctor_female.png',
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.contain,
                                ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        doctorName,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: AppColors.ge1,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        specialty,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.ge2,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Verification and Status Badges
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.g1, // Green for verified
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Text(
                          'Verified',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.b4, // Blue for volunteer
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Text(
                          'Volunteer',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Performance Metrics (Cards)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Ratings Card
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.bg1,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/book_appointment/star.png',
                                    width: 20,
                                    height: 20,
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    rating.toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.ge1,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Ratings',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.ge2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Patients Treated Card
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.bg1,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/book_appointment/holding_hands.png',
                                    width: 20,
                                    height: 20,
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(width: 4),
                                  const Text(
                                    '500+',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.ge1,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Patients Treated',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.ge2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Experience Card
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.bg1,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/book_appointment/badge.png',
                                    width: 20,
                                    height: 20,
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(width: 4),
                                  const Text(
                                    '15 Years',
                                    style: TextStyle(
                                      fontSize: 14, // Reduced font size to prevent overflow
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.ge1,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Experience',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.ge2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // About Doctor Section
            Container(
              color: AppColors.white,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'About Doctor',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.ge1,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Dr. $doctorName is a highly experienced $specialty with over 10 years of experience in the field of medicine. Specializing in $specialty and related conditions. Dr. $doctorName completed their MD in $specialty from a prestigious medical college and is board-certified. They are passionate about providing personalized care and staying up-to-date with the latest medical treatments and technologies. Dr. $doctorName has treated over 1000 patients and has received multiple awards for excellence in patient care.',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.ge2,
                      fontFamily: 'Roboto',
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Working Hours Section
            Container(
              color: AppColors.white,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Working Hours',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.ge1,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildWorkingHourChip('10:30am - 12:30pm', true),
                        const SizedBox(width: 8),
                        _buildWorkingHourChip('4:30pm - 7:30pm', false),
                        const SizedBox(width: 8),
                        _buildWorkingHourChip('8:00pm - 10:00pm', false),
                        const SizedBox(width: 8),
                        _buildWorkingHourChip('Tomorrow 9:00am - 11:00am', false),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Languages Spoken Section
            Container(
              color: AppColors.white,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Languages Spoken',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.ge1,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildLanguageChip('English', true),
                        const SizedBox(width: 8),
                        _buildLanguageChip('Hindi', false),
                        const SizedBox(width: 8),
                        _buildLanguageChip('Tamil', false),
                        const SizedBox(width: 8),
                        _buildLanguageChip('Telugu', false),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Reviews Section
            Container(
              color: AppColors.white,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Reviews',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.ge1,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'View all',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.b4,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        List<String> names = ['John Doe', 'Jane Smith', 'Robert Johnson'];
                        List<String> reviews = [
                          'Great doctor! Very patient and knowledgeable. Explained everything clearly.',
                          'Excellent treatment and follow-up care. Highly recommended!',
                          'Professional and caring. Made me feel comfortable during the consultation.'
                        ];
                        List<int> ratings = [5, 4, 5];
                        
                        return Container(
                          width: 280,
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.bg1,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: AppColors.b3,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        'assets/book_appointment/user.png',
                                        width: 20,
                                        height: 20,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    names[index],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.ge1,
                                    ),
                                  ),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      for (int i = 0; i < 5; i++)
                                        Icon(
                                          i < ratings[index]
                                              ? Icons.star
                                              : Icons.star_border,
                                          size: 14,
                                          color: AppColors.b4,
                                        ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${ratings[index]}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: AppColors.ge1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                reviews[index],
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.ge2,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the Book Appointment screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookAppointmentScreen(
                  doctorName: doctorName,
                  doctorSpecialization: specialty,
                  doctorImage: isMale
                      ? 'assets/doctor_profile/doctor_male.png'
                      : 'assets/doctor_profile/doctor_female.png',
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.b4,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Book Appointment',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.white,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to create working hour chips
  Widget _buildWorkingHourChip(String time, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.b4 : AppColors.bg1,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? AppColors.b4 : AppColors.ge3,
        ),
      ),
      child: Text(
        time,
        style: TextStyle(
          fontSize: 14,
          color: isSelected ? AppColors.white : AppColors.ge1,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }

  // Helper method to create language chips
  Widget _buildLanguageChip(String language, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.b4 : AppColors.bg1,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? AppColors.b4 : AppColors.ge3,
        ),
      ),
      child: Text(
        language,
        style: TextStyle(
          fontSize: 14,
          color: isSelected ? AppColors.white : AppColors.ge1,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }
}