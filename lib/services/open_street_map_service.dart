import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenStreetMapService {
  static const String _baseUrl = 'https://nominatim.openstreetmap.org';

  /// Search for locations based on query
  Future<List<LocationResult>> searchLocations(String query) async {
    try {
      final url = '$_baseUrl/search?format=json&q=$query';
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'User-Agent': 'Clinico-App/1.0',
        },
      );

      if (response.statusCode == 20) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => LocationResult.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load locations: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error searching locations: $e');
    }
  }

  /// Get address details from coordinates (reverse geocoding)
  Future<String> getAddressFromCoordinates(double lat, double lon) async {
    try {
      final url = '$_baseUrl/reverse?format=json&lat=$lat&lon=$lon';
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'User-Agent': 'Clinico-App/1.0',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['display_name'] ?? 'Unknown location';
      } else {
        throw Exception('Failed to get address: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting address: $e');
    }
  }
}

class LocationResult {
  final String displayName;
  final double latitude;
  final double longitude;
  final String? address;
  final String? category;
  final String? type;

  LocationResult({
    required this.displayName,
    required this.latitude,
    required this.longitude,
    this.address,
    this.category,
    this.type,
  });

  factory LocationResult.fromJson(Map<String, dynamic> json) {
    return LocationResult(
      displayName: json['display_name'] ?? '',
      latitude: double.tryParse(json['lat']?.toString() ?? '0') ?? 0,
      longitude: double.tryParse(json['lon']?.toString() ?? '0') ?? 0,
      address: json['address']?['display_name'],
      category: json['category'],
      type: json['type'],
    );
  }
}