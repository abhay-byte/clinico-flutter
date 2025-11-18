class DoctorLocation {
  final int id;
  final String name;
  final String specialty;
  final String qualifications;
  final String hospital;
  final double latitude;
  final double longitude;
  final double rating;
  final String profileImageUrl;
  final int distanceInMeters;

  DoctorLocation({
    required this.id,
    required this.name,
    required this.specialty,
    required this.qualifications,
    required this.hospital,
    required this.latitude,
    required this.longitude,
    required this.rating,
    required this.profileImageUrl,
    required this.distanceInMeters,
  });

  double get distanceInKm => distanceInMeters / 1000;

  factory DoctorLocation.fromJson(Map<String, dynamic> json) {
    return DoctorLocation(
      id: json['id'] as int,
      name: json['name'] as String,
      specialty: json['specialty'] as String,
      qualifications: json['qualifications'] as String,
      hospital: json['hospital'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      profileImageUrl: json['profileImageUrl'] as String? ?? '',
      distanceInMeters: json['distanceInMeters'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'specialty': specialty,
    'qualifications': qualifications,
    'hospital': hospital,
    'latitude': latitude,
    'longitude': longitude,
    'rating': rating,
    'profileImageUrl': profileImageUrl,
    'distanceInMeters': distanceInMeters,
  };
}

class UserLocation {
  final double latitude;
  final double longitude;
  final double? accuracy;
  final double? altitude;
  final double? heading;
  final double? speed;

  UserLocation({
    required this.latitude,
    required this.longitude,
    this.accuracy,
    this.altitude,
    this.heading,
    this.speed,
  });

  factory UserLocation.fromJson(Map<String, dynamic> json) {
    return UserLocation(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      accuracy: (json['accuracy'] as num?)?.toDouble(),
      altitude: (json['altitude'] as num?)?.toDouble(),
      heading: (json['heading'] as num?)?.toDouble(),
      speed: (json['speed'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'latitude': latitude,
    'longitude': longitude,
    'accuracy': accuracy,
    'altitude': altitude,
    'heading': heading,
    'speed': speed,
  };
}
