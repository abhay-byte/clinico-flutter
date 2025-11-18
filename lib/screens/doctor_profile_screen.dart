import 'package:flutter/material.dart';
import '../constants/colors.dart';

class DoctorProfileScreen extends StatelessWidget {
  final String doctorName;
  final String specialty;
  final String qualifications;
  final String hospital;
  final double rating;
  final double distance;
  final bool isMale;

  const DoctorProfileScreen({
    super.key,
    required this.doctorName,
    required this.specialty,
    required this.qualifications,
    required this.hospital,
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
          icon: const Icon(Icons.arrow_back, color: AppColors.ge1),
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
                  Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: AppColors.b3,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Image.asset(
                            isMale
                                ? 'assets/home/serach/doctor_male.png'
                                : 'assets/home/serach/doctor_female.png',
                            width: 60,
                            height: 60,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              doctorName,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppColors.ge1,
                                fontFamily: 'Roboto',
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '$specialty | $qualifications',
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.ge2,
                                fontFamily: 'Roboto',
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              hospital,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.ge2,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Rating and Distance
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/home/star.png',
                            width: 16,
                            height: 16,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            rating.toStringAsFixed(1),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.ge1,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/home/location.png',
                            width: 16,
                            height: 16,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${distance.toStringAsFixed(1)} km away',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.ge1,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Appointment Booking Section
            Container(
              color: AppColors.white,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Book Appointment',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.ge1,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: AppColors.b4),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Clinic Visit',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.b4,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: AppColors.b4),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Video Call',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.b4,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: AppColors.b4),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Call',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.b4,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: AppColors.b4),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Chat',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.b4,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // About Section
            Container(
              color: AppColors.white,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'About',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.ge1,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Dr. Lorem Ipsum is a highly experienced physician with over 10 years of experience in the field of medicine. Specializing in general practice with a focus on preventive care and patient education.',
                    style: TextStyle(
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
            // Services Section
            Container(
              color: AppColors.white,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Services',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.ge1,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '• General Consultation\n• Preventive Care\n• Health Screening\n• Chronic Disease Management\n• Vaccinations',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.ge2,
                      fontFamily: 'Roboto',
                      height: 1.5,
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
          onPressed: () {},
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
}