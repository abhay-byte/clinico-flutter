import 'dart:math';
import '../models/doctor_location_model.dart';

class DoctorLocationService {
  /// Calculate distance between two coordinates (in meters)
  /// Uses Haversine formula
  double _calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const earthRadius = 6371000; // meters

    final dLat = _toRadians(lat2 - lat1);
    final dLon = _toRadians(lon2 - lon1);

    final a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) *
            cos(_toRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  double _toRadians(double degree) {
    return degree * (pi / 180);
  }

  /// Get mock doctor locations near user
  /// In production, this would fetch from an API
  Future<List<DoctorLocation>> getNearbyDoctors({
    required double userLatitude,
    required double userLongitude,
    String specialty = 'Dermatologist',
  }) async {
    // Mock doctor data - Delhi area coordinates
    final mockDoctors = [
      DoctorLocation(
        id: 1,
        name: 'Dr. Sharma',
        specialty: specialty,
        qualifications: 'MBBS, MD',
        hospital: 'ABC Hospital',
        latitude: 28.6089,
        longitude: 77.2300,
        rating: 4.7,
        profileImageUrl: '',
        distanceInMeters: 1600,
      ),
      DoctorLocation(
        id: 2,
        name: 'Dr. Patel',
        specialty: specialty,
        qualifications: 'MBBS, MD',
        hospital: 'XYZ Clinic',
        latitude: 28.6150,
        longitude: 77.2100,
        rating: 4.5,
        profileImageUrl: '',
        distanceInMeters: 1200,
      ),
      DoctorLocation(
        id: 3,
        name: 'Dr. Kumar',
        specialty: specialty,
        qualifications: 'MBBS, MD, DNB',
        hospital: 'Healing Touch Hospital',
        latitude: 28.6200,
        longitude: 77.2050,
        rating: 4.8,
        profileImageUrl: '',
        distanceInMeters: 1800,
      ),
      DoctorLocation(
        id: 4,
        name: 'Dr. Singh',
        specialty: specialty,
        qualifications: 'MBBS, MD',
        hospital: 'Care Plus Hospital',
        latitude: 28.6000,
        longitude: 77.2200,
        rating: 4.6,
        profileImageUrl: '',
        distanceInMeters: 2100,
      ),
      DoctorLocation(
        id: 5,
        name: 'Dr. Desai',
        specialty: specialty,
        qualifications: 'MBBS, MD',
        hospital: 'Wellness Center',
        latitude: 28.6250,
        longitude: 77.2150,
        rating: 4.4,
        profileImageUrl: '',
        distanceInMeters: 2500,
      ),
    ];

    // Calculate actual distances from user location
    return mockDoctors.map((doctor) {
      final distance = _calculateDistance(
        userLatitude,
        userLongitude,
        doctor.latitude,
        doctor.longitude,
      );

      return DoctorLocation(
        id: doctor.id,
        name: doctor.name,
        specialty: doctor.specialty,
        qualifications: doctor.qualifications,
        hospital: doctor.hospital,
        latitude: doctor.latitude,
        longitude: doctor.longitude,
        rating: doctor.rating,
        profileImageUrl: doctor.profileImageUrl,
        distanceInMeters: distance.toInt(),
      );
    }).toList();
  }

  /// Search doctors by specialty
  Future<List<DoctorLocation>> searchDoctors({
    required String specialty,
    required double userLatitude,
    required double userLongitude,
  }) async {
    return getNearbyDoctors(
      userLatitude: userLatitude,
      userLongitude: userLongitude,
      specialty: specialty,
    );
  }

  /// Get doctor by ID
  Future<DoctorLocation?> getDoctorById(
    int id,
    double userLatitude,
    double userLongitude,
  ) async {
    final doctors = await getNearbyDoctors(
      userLatitude: userLatitude,
      userLongitude: userLongitude,
    );

    try {
      return doctors.firstWhere((doctor) => doctor.id == id);
    } catch (e) {
      return null;
    }
  }
}
