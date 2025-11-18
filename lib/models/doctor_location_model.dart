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
}