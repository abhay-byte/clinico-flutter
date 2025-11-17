import 'package:flutter/material.dart';
import '../constants/colors.dart';

class DoctorCard extends StatelessWidget {
  final String doctorName;
  final String specialty;
  final String credentials;
  final String hospital;
  final double rating;
  final double distance;
  final bool isMale;

  const DoctorCard({
    Key? key,
    required this.doctorName,
    required this.specialty,
    required this.credentials,
    required this.hospital,
    required this.rating,
    required this.distance,
    required this.isMale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Column A: Doctor Avatar (Left)
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.b3,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Image.asset(
                isMale
                    ? 'assets/home/serach/doctor_male.png'
                    : 'assets/home/serach/doctor_female.png',
                width: 40,
                height: 40,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Column B: Doctor Information (Center)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Doctor Name
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
                // Professional Details (Specialty | Credentials | Hospital)
                Text(
                  '$specialty | $credentials | $hospital',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.ge2,
                    fontFamily: 'Roboto',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // Column C: Quick Metrics (Right)
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Rating with star icon
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/home/star.png',
                    width: 14,
                    height: 14,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    rating.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.ge1,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              // Distance with location icon
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/home/location.png',
                    width: 12,
                    height: 12,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${distance.toStringAsFixed(1)} km',
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.ge2,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
