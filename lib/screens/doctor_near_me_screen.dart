import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../models/doctor_location_model.dart';
import '../services/location_service.dart';
import '../services/doctor_location_service.dart';

class DoctorNearMeScreen extends StatefulWidget {
  const DoctorNearMeScreen({super.key});

  @override
  State<DoctorNearMeScreen> createState() => _DoctorNearMeScreenState();
}

class _DoctorNearMeScreenState extends State<DoctorNearMeScreen> {
  final LocationService _locationService = LocationService();
  final DoctorLocationService _doctorLocationService = DoctorLocationService();

  late MapController _mapController;
  UserLocation? _userLocation;
  List<DoctorLocation> _nearbyDoctors = [];
  DoctorLocation? _selectedDoctor;
  bool _isLoading = true;
  final String _searchQuery = 'Dermatologist Near me';

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeLocation();
    });
  }

  Future<void> _initializeLocation() async {
    try {
      // Request location permission upfront
      final hasPermission = await _locationService.requestLocationPermission();
      if (!hasPermission && mounted) {
        debugPrint('Location permission denied');
      }

      // Get user location
      UserLocation? location = await _locationService.getCurrentLocation();
      location ??= _locationService.getDefaultLocation();

      if (!mounted) return;

      setState(() {
        _userLocation = location;
      });

      // Fetch nearby doctors
      final doctors = await _doctorLocationService.getNearbyDoctors(
        userLatitude: location.latitude,
        userLongitude: location.longitude,
        specialty: 'Dermatologist',
      );

      if (!mounted) return;

      setState(() {
        _nearbyDoctors = doctors;
        if (doctors.isNotEmpty) {
          _selectedDoctor = doctors.first;
        }
        _isLoading = false;
      });

      // Center map on user location with small delay to ensure map is rendered
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted && location != null) {
          _mapController.move(
            LatLng(location.latitude, location.longitude),
            15.0,
          );
        }
      });
    } catch (e) {
      debugPrint('Error initializing location: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _onDoctorMarkerTap(DoctorLocation doctor) {
    setState(() {
      _selectedDoctor = doctor;
    });

    // Animate map to doctor location
    _mapController.move(LatLng(doctor.latitude, doctor.longitude), 16.0);
  }

  void _onViewButtonPressed() {
    if (_selectedDoctor != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Viewing ${_selectedDoctor!.name}'),
          duration: const Duration(seconds: 2),
        ),
      );
      // TODO: Navigate to doctor profile page
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  // Map View (Full background)
                  if (_userLocation != null)
                    Positioned.fill(child: _buildMapView())
                  else
                    const Center(child: Text('Unable to get location')),

                  // Search Bar (overlay)
                  Column(
                    children: [const SizedBox(height: 12), _buildSearchBar()],
                  ),

                  // Doctor Detail Card (floating bottom)
                  if (_selectedDoctor != null)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: _buildDoctorDetailCard(),
                    ),
                ],
              ),
      ),
    );
  }

  Widget _buildMapView() {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: LatLng(
          _userLocation!.latitude,
          _userLocation!.longitude,
        ),
        initialZoom: 15.0,
        maxZoom: 18.0,
        minZoom: 5.0,
      ),
      children: [
        // OpenStreetMap tile layer
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: const ['a', 'b', 'c'],
          userAgentPackageName: 'com.clinico.app',
        ),
        // Marker layer
        MarkerLayer(
          markers: [
            // User location marker
            Marker(
              width: 60,
              height: 60,
              point: LatLng(_userLocation!.latitude, _userLocation!.longitude),
              child: _buildUserLocationMarker(),
            ),
            // Doctor location markers
            ..._nearbyDoctors.map(
              (doctor) => Marker(
                width: 50,
                height: 50,
                point: LatLng(doctor.latitude, doctor.longitude),
                child: GestureDetector(
                  onTap: () => _onDoctorMarkerTap(doctor),
                  child: _buildDoctorMarker(
                    isSelected: _selectedDoctor?.id == doctor.id,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUserLocationMarker() {
    return Image.asset(
      'assets/home/location.png',
      width: 60,
      height: 60,
      fit: BoxFit.contain,
    );
  }

  Widget _buildDoctorMarker({required bool isSelected}) {
    return Image.asset(
      'assets/ai_chat/doctor_location.png',
      width: isSelected ? 56 : 48,
      height: isSelected ? 56 : 48,
      fit: BoxFit.contain,
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Image.asset(
              'assets/ai_chat/search_icon.png',
              width: 24,
              height: 24,
              color: Colors.grey[400],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: _searchQuery,
                  hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                readOnly: true,
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/ai_chat/filter_icon.png',
                  width: 28,
                  height: 28,
                  color: Colors.grey[400],
                ),
                Positioned(
                  right: 0,
                  top: 8,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Center(
                      child: Text(
                        '1',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorDetailCard() {
    if (_selectedDoctor == null) return const SizedBox.shrink();

    final doctor = _selectedDoctor!;
    final distanceKm = (doctor.distanceInMeters / 1000).toStringAsFixed(1);

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Doctor header with image, name, specialty
          Row(
            children: [
              // Doctor icon/image placeholder
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: const Icon(Icons.person_outline, color: Colors.grey),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${doctor.specialty} | ${doctor.qualifications}',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Hospital info
          Text(
            doctor.hospital,
            style: TextStyle(color: Colors.grey[600], fontSize: 13),
          ),
          const SizedBox(height: 12),

          // Distance, rating, and action button
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$distanceKm Km Away',
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.star, size: 16, color: Colors.amber),
                  const SizedBox(width: 4),
                  Text(
                    doctor.rating.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF248BEB),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                onPressed: _onViewButtonPressed,
                child: const Text(
                  'View',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
}
