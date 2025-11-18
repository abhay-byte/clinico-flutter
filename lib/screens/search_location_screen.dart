import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../constants/colors.dart';
import '../services/location_service.dart';
import '../services/open_street_map_service.dart';

class SearchLocationScreen extends StatefulWidget {
  final Function(String locationName, double latitude, double longitude)? onLocationSelected;

  const SearchLocationScreen({super.key, this.onLocationSelected});

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  final TextEditingController _searchController = TextEditingController();
  final LocationService _locationService = LocationService();
  final OpenStreetMapService _osmService = OpenStreetMapService();
  List<LocationResult> _searchResults = [];
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    final status = await Permission.location.request();
    if (status.isDenied) {
      // Show a dialog to request permission
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Location Permission Required'),
          content: const Text('This app needs location permission to show your current location. Please enable it in settings.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => openAppSettings(),
              child: const Text('Settings'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _performSearch(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        _searchResults = [];
        _errorMessage = '';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final results = await _osmService.searchLocations(query);
      setState(() {
        _searchResults = results;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error searching locations: $e';
        _searchResults = [];
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final location = await _locationService.getCurrentLocation();
      if (location != null) {
        // Get address from coordinates
        final address = await _osmService.getAddressFromCoordinates(
          location.latitude,
          location.longitude,
        );
        
        // Call the callback with the current location
        if (widget.onLocationSelected != null) {
          widget.onLocationSelected!(address, location.latitude, location.longitude);
        }
        
        Navigator.of(context).pop();
      } else {
        setState(() {
          _errorMessage = 'Unable to get current location. Please enable location services.';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error getting current location: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

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
          'Select Location',
          style: TextStyle(
            color: AppColors.ge1,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Image.asset(
                      'assets/home/search.png',
                      width: 20,
                      height: 20,
                      color: AppColors.ge2,
                    ),
                  ),
                  hintText: 'Search for a location',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: AppColors.ge2,
                    fontFamily: 'Roboto',
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onChanged: (value) => _performSearch(value),
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.ge1,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Current Location Button
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: _getCurrentLocation,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/home/location/current_location.png',
                          width: 20,
                          height: 20,
                          color: AppColors.g1,
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Use my current location',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.ge1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Loading indicator
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.all(16),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),

            // Error message
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  _errorMessage,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

            // Search Results
            if (!_isLoading && _searchResults.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    final location = _searchResults[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            if (widget.onLocationSelected != null) {
                              widget.onLocationSelected!(
                                location.displayName,
                                location.latitude,
                                location.longitude,
                              );
                            }
                            Navigator.of(context).pop();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  location.displayName,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.ge1,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                if (location.category != null || location.type != null) ...[
                                  const SizedBox(height: 4),
                                  Text(
                                    '${location.category ?? ''}${location.category != null && location.type != null ? ' • ' : ''}${location.type ?? ''}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.ge2,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

            // No results message
            if (!_isLoading && _searchResults.isEmpty && _searchController.text.isNotEmpty && _errorMessage.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    'No locations found. Try a different search term.',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.ge2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}