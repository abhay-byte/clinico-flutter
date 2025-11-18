import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../components/doctor_card.dart';
import '../components/search_filter_modal.dart';
import '../screens/search_location_screen.dart';

class SearchScreen extends StatefulWidget {
  final String? initialQuery;

  const SearchScreen({super.key, this.initialQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchController;
  final FocusNode _searchFocusNode = FocusNode();
  String _searchQuery = '';

  // Sample doctor data
  final List<Map<String, dynamic>> _allDoctorResults = [
    {
      'name': 'Dr. Lorem Ipsum',
      'specialty': 'Dermatologist',
      'credentials': 'MBBS, MD',
      'hospital': 'ABC Hos...',
      'rating': 4.7,
      'distance': 1.6,
      'isMale': true,
    },
    {
      'name': 'Dr. Lorem Ipsum',
      'specialty': 'Dermatologist',
      'credentials': 'MBBS, MD',
      'hospital': 'XYZ Hos...',
      'rating': 4.2,
      'distance': 2.2,
      'isMale': false,
    },
    {
      'name': 'Dr. Lorem Ipsum',
      'specialty': 'Dermatologist',
      'credentials': 'MBBS, MD',
      'hospital': 'LMN Hos...',
      'rating': 3.9,
      'distance': 5.6,
      'isMale': false,
    },
    {
      'name': 'Dr. Lorem Ipsum',
      'specialty': 'Dermatologist',
      'credentials': 'MBBS, MD',
      'hospital': 'PQR Hos...',
      'rating': 3.8,
      'distance': 7.1,
      'isMale': true,
    },
  ];

  // Get filtered doctor results based on search query
  List<Map<String, dynamic>> get _filteredDoctorResults {
    if (_searchQuery.isEmpty) {
      return _allDoctorResults;
    }

    return _allDoctorResults.where((doctor) {
      final query = _searchQuery.toLowerCase();
      return doctor['name'].toLowerCase().contains(query) ||
          doctor['specialty'].toLowerCase().contains(query) ||
          doctor['credentials'].toLowerCase().contains(query) ||
          doctor['hospital'].toLowerCase().contains(query);
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialQuery ?? '');
    if (widget.initialQuery != null && widget.initialQuery!.isNotEmpty) {
      _searchQuery = widget.initialQuery!;
    }
    // Add listener to update search query on text change
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
    // Request focus to show keyboard
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _showSearchFilterModal() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SearchFilterModal(
        onApply: () {
          // Handle apply filter
          print('Filters applied');
        },
        onClearAll: () {
          // Handle clear all filters
          print('All filters cleared');
        },
        onDismiss: () {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg1,
      body: Column(
        children: [
          // Search Bar at Top
          _buildSearchBar(),

          // Search Results List
          Expanded(
            child: Stack(
              children: [
                // Results ListView
                ListView.builder(
                  padding: const EdgeInsets.only(top: 0, bottom: 20),
                  itemCount: _filteredDoctorResults.length,
                  itemBuilder: (context, index) {
                    final doctor = _filteredDoctorResults[index];
                    return DoctorCard(
                      doctorName: doctor['name'],
                      specialty: doctor['specialty'],
                      credentials: doctor['credentials'],
                      hospital: doctor['hospital'],
                      rating: doctor['rating'],
                      distance: doctor['distance'],
                      isMale: doctor['isMale'],
                    );
                  },
                ),

                // Dark translucent overlay at bottom (keyboard area)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0),
                          Colors.black.withOpacity(0.3),
                        ],
                      ),
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

  Widget _buildSearchBar() {
    return SafeArea(
      child: Container(
        color: AppColors.bg1,
        padding: const EdgeInsets.all(20),
        child: Container(
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
            focusNode: _searchFocusNode,
            decoration: InputDecoration(
              prefixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Location icon
                  GestureDetector(
                    onTap: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SearchLocationScreen(
                            onLocationSelected: (locationName, latitude, longitude) {
                              // You can update the location context here if needed
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Location selected: $locationName'),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      child: Image.asset(
                        'assets/home/location.png',
                        width: 20,
                        height: 20,
                        color: AppColors.g1,
                      ),
                    ),
                  ),
                  // Search icon
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Image.asset(
                      'assets/home/search.png',
                      width: 20,
                      height: 20,
                      color: AppColors.ge2,
                    ),
                  ),
                ],
              ),
              suffixIcon: GestureDetector(
                onTap: _showSearchFilterModal,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Image.asset(
                    'assets/home/filter.png',
                    width: 20,
                    height: 20,
                    color: AppColors.ge2,
                  ),
                ),
              ),
              hintText: 'Dermatologist Near Me',
              hintStyle: const TextStyle(
                fontSize: 14,
                color: AppColors.ge2,
                fontFamily: 'Roboto',
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.ge1,
              fontFamily: 'Roboto',
            ),
          ),
        ),
      ),
    );
  }
}
