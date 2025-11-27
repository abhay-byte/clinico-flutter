import 'package:flutter/material.dart';
import '../constants/colors.dart';

class TopDoctorsCard extends StatelessWidget {
  final String doctorName;
  final String specialty;
  final String credentials;
  final String hospital;
  final double rating;
  final double distance;
  final bool isMale;
  final VoidCallback onViewPressed;

  const TopDoctorsCard({
    super.key,
    required this.doctorName,
    required this.specialty,
    required this.credentials,
    required this.hospital,
    required this.rating,
    required this.distance,
    required this.isMale,
    required this.onViewPressed,
  });

  @override
 Widget build(BuildContext context) {
    return Container(
      width: 260, // Reduced width to prevent overflow
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.ge2.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top Section (Profile)
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Doctor Image
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: AppColors.b3,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      isMale
                          ? 'assets/home/serach/doctor_male.png'
                          : 'assets/home/serach/doctor_female.png',
                      width: 30,
                      height: 30,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                
                // Text Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Name: "Dr. Lorem Ipsum" (Black, Medium weight)
                      Text(
                        doctorName,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.ge1,
                          fontFamily: 'Roboto',
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      // Details: "Physician | MBBS, MD | ABC Hospital" (Grey, Smaller font, max 2 lines)
                      Text(
                        '$specialty | $credentials | $hospital',
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppColors.ge2,
                          fontFamily: 'Roboto',
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Divider
          Container(
            height: 1,
            color: AppColors.ge2.withOpacity(0.3),
            margin: const EdgeInsets.symmetric(horizontal: 12),
          ),
          
          // Bottom Section (Status & Action)
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Element 1 (Distance)
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: AppColors.ge2,
                      size: 14,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '${distance.toStringAsFixed(1)} Km',
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.ge2,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
                
                // Element 2 (Rating)
                Row(
                  children: [
                    Image.asset(
                      'assets/home/star.png',
                      width: 12,
                      height: 12,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      rating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.ge1,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
                
                // Element 3 (Button)
                ElevatedButton(
                  onPressed: onViewPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.b4,
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    minimumSize: const Size(35, 22),
                  ),
                  child: const Text(
                    'View',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}