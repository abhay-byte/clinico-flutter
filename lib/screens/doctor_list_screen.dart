import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../components/search_filter_modal.dart';
import 'doctor_profile_screen.dart';

class DoctorListScreen extends StatefulWidget {
  const DoctorListScreen({super.key});

  @override
  State<DoctorListScreen> createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  
  // Filter data
  FilterData _filters = FilterData();
  
  // Sample doctor data as per specifications
  final List<Map<String, dynamic>> _allDoctors = [
    {
      'name': 'Dr. Lorem Ipsum',
      'specialty': 'Dermatologist',
      'credentials': 'MBBS, MD',
      'hospital': 'ABC Hospital',
      'rating': 4.7,
      'distance': 1.6,
      'isMale': true,
    },
    {
      'name': 'Dr. Lorem Ipsum',
      'specialty': 'Dermatologist',
      'credentials': 'MBBS, MD',
      'hospital': 'XYZ Hospital',
      'rating': 4.2,
      'distance': 2.2,
      'isMale': false,
    },
    {
      'name': 'Dr. Lorem Ipsum',
      'specialty': 'Dermatologist',
      'credentials': 'MBBS, MD',
      'hospital': 'LMN Hospital',
      'rating': 3.9,
      'distance': 5.6,
      'isMale': false,
    },
    {
      'name': 'Dr. Lorem Ipsum',
      'specialty': 'Dermatologist',
      'credentials': 'MBBS, MD',
      'hospital': 'PQR Hospital',
      'rating': 3.8,
      'distance': 7.1,
      'isMale': true,
    },
    {
      'name': 'Dr. Lorem Ipsum',
      'specialty': 'Dermatologist',
      'credentials': 'MBBS, MD',
      'hospital': 'DEF Hospital',
      'rating': 4.9,
      'distance': 3.2,
      'isMale': true,
    },
    {
      'name': 'Dr. Lorem Ipsum',
      'specialty': 'Dermatologist',
      'credentials': 'MBBS, MD',
      'hospital': 'GHI Hospital',
      'rating': 4.5,
      'distance': 4.8,
      'isMale': false,
    },
  ];

  // Get filtered doctor results based on search query and filters
  List<Map<String, dynamic>> get _filteredDoctors {
    List<Map<String, dynamic>> filtered = _allDoctors;
    
    // Apply search query filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((doctor) {
        final query = _searchQuery.toLowerCase();
        return doctor['name'].toLowerCase().contains(query) ||
            doctor['specialty'].toLowerCase().contains(query) ||
            doctor['credentials'].toLowerCase().contains(query) ||
            doctor['hospital'].toLowerCase().contains(query);
      }).toList();
    }
    
    // Apply specialisation filter
    if (_filters.specialisation != 'Physician') {
      filtered = filtered.where((doctor) {
        return doctor['specialty'].toLowerCase().contains(_filters.specialisation.toLowerCase());
      }).toList();
    }
    
    // Apply rating filter
    if (_filters.rating == '> 4 ★') {
      filtered = filtered.where((doctor) => doctor['rating'] >= 4.0).toList();
    } else if (_filters.rating == '> 3 ★') {
      filtered = filtered.where((doctor) => doctor['rating'] >= 3.0).toList();
    }
    
    // Apply volunteers filter (currently no volunteer field in sample data, so skipping)
    // Apply availability filter (currently no availability data in sample, so skipping)
    
    // Apply sorting
    switch (_filters.sortBy) {
      case 'Rating':
        filtered.sort((a, b) => b['rating'].compareTo(a['rating']));
        break;
      case 'Distance':
        filtered.sort((a, b) => a['distance'].compareTo(b['distance']));
        break;
      // Note: Other sort options like 'Price' and 'Recommendation' are not applicable to sample data
      default:
        // Default sorting by distance
        filtered.sort((a, b) => a['distance'].compareTo(b['distance']));
        break;
    }
    
    return filtered;
  }

  @override
  void initState() {
    super.initState();
    // Add listener to update search query on text change
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8), // Light gray background as specified
      body: Column(
        children: [
          // Search Bar (Top Header)
          _buildSearchBar(),
          
          // Doctor List Container with rounded corners
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16), // Horizontal padding as specified
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: const BorderRadius.all(Radius.circular(16)), // Rounded corners as specified
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: _filteredDoctors.length,
                itemBuilder: (context, index) {
                  final doctor = _filteredDoctors[index];
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigate to doctor profile screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DoctorProfileScreen(
                                doctorName: doctor['name'],
                                specialty: doctor['specialty'],
                                rating: doctor['rating'],
                                distance: doctor['distance'],
                                isMale: doctor['isMale'],
                              ),
                            ),
                          );
                        },
                        child: _buildDoctorListItem(doctor),
                      ),
                      // Add divider between items, but not for the last item
                      if (index < _filteredDoctors.length - 1)
                        const Divider(
                          height: 1,
                          thickness: 0.5,
                          indent: 70, // Start after the avatar image
                          endIndent: 16, // End before the right stats
                          color: Color(0xFFE0E0E0), // Light grey color
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 16), // Top padding for status bar + specified padding
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(50), // Fully rounded corners (stadium shape)
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2), // Soft drop shadow
            ),
          ],
        ),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            prefixIcon: Container(
              padding: const EdgeInsets.all(12),
              child: Image.asset(
                'assets/home/search.png', // Search icon as specified
                width: 20,
                height: 20,
                color: Colors.grey,
              ),
            ),
            hintText: 'Dermatologist Near Me', // Placeholder text as specified
            hintStyle: const TextStyle(
              color: Color(0xFF9E9E9E), // Dark grey color
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                // Show filter options when filter icon is tapped
                _showFilterOptions();
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                child: Image.asset(
                  'assets/home/filter.png', // Filter icon as specified
                  width: 20,
                  height: 20,
                  color: Colors.grey,
                ),
              ),
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          ),
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorListItem(Map<String, dynamic> doctor) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Left Section: Avatar
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD), // Light blue background
              borderRadius: BorderRadius.circular(25), // Circular shape
            ),
            child: Center(
              child: Image.asset(
                doctor['isMale'] 
                  ? 'assets/doctor_profile/doctor_male.png' 
                  : 'assets/doctor_profile/doctor_female.png',
                width: 30,
                height: 30,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(width: 16), // Spacing between avatar and info
          
          // Middle Section: Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Doctor Name
                Text(
                  doctor['name'],
                  style: const TextStyle(
                    fontSize: 16, // 14px-16px as specified
                    fontWeight: FontWeight.w600, // Semi-bold
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                // Subtitle: Specialty, Credentials, Hospital
                Text(
                  '${doctor['specialty']} | ${doctor['credentials']} | ${doctor['hospital']}',
                  style: const TextStyle(
                    fontSize: 12, // Smaller font as specified
                    color: Color(0xFF9E9E9E), // Grey color as specified
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16), // Spacing between info and stats
          
          // Right Section: Stats
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Top Row: Rating
              Row(
                children: [
                  Image.asset(
                    'assets/home/star.png', // Star icon as specified
                    width: 14,
                    height: 14,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    doctor['rating'].toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8), // Spacing between rating and distance
              // Bottom Row: Distance
              Row(
                children: [
                  Image.asset(
                    'assets/home/location.png', // Location pin as specified
                    width: 12,
                    height: 12,
                    color: const Color(0xFF9E9E9E), // Grey color
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${doctor['distance']} km',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF9E9E9E), // Grey color
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

  void _showFilterOptions() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SearchFilterModal(
        onApply: (filterData) {
          // Handle apply filter
          setState(() {
            _filters = filterData;
          });
          Navigator.of(context).pop(); // Close the modal
        },
        onClearAll: () {
          // Handle clear all filters
          setState(() {
            _filters = FilterData(); // Reset to default filters
          });
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
}
