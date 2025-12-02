import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../components/location_selection_modal.dart';
import '../components/search_filter_modal.dart';
import '../components/top_doctors_card.dart';
import '../screens/search_screen.dart';
import '../screens/ai_chat_screen.dart';
import '../screens/doctor_list_screen.dart';
import '../screens/doctor_profile_screen.dart';
import '../screens/search_location_screen.dart';
import '../pages/user_profile_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String currentLocation = 'New Delhi, India';

  void _showLocationSelectionModal() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => LocationSelectionModal(
        onLocationSelected: () async {
          // Handle location selection by navigating to search location screen
          Navigator.of(context).pop(); // Close the modal first
          
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchLocationScreen(
                onLocationSelected: (locationName, latitude, longitude) {
                  // Update the current location in the home screen
                  setState(() {
                    currentLocation = locationName;
                  });
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Location updated to: $locationName'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              ),
            ),
          );
        },
        onDismiss: () {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }

  void _showSearchFilterModal() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SearchFilterModal(
        onApply: (filterData) {
          // Handle apply filter
          print('Filters applied: ${filterData.specialisation}');
          Navigator.of(context).pop(); // Close the modal
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
      body: _buildBody(),
      // bottomNavigationBar: _buildBottomNavBar(), // Removed as it's handled by MainAppScreen
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Spacing
          const SizedBox(height: 60),

          // Location & Search Bar Section
          _buildLocationSearchSection(),

          // Upcoming Appointments Section
          _buildUpcomingAppointmentsSection(),

          // Looking For Specialist Card
          _buildSpecialistCard(),

          // Chat with Elphie Card
          _buildElphieCard(),

          // Categories Section
          _buildCategoriesSection(),

          // Top Doctors Section
          _buildTopDoctorsSection(),

          // Services Section
          _buildServicesSection(),

          const SizedBox(height: 30),
          
          // Bottom padding to prevent content from being cut off by bottom navigation
          const SizedBox(height: 80), // Added to account for bottom navigation bar
        ],
      ),
    );
  }

  // Location & Search Bar Section
  Widget _buildLocationSearchSection() {
    return Container(
      color: AppColors.bg1,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Location Selector
          Row(
            children: [
              Image.asset('assets/home/location.png', width: 20, height: 20),
              const SizedBox(width: 8),
              const Text(
                'Location',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.ge2,
                  fontFamily: 'Roboto',
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: _showLocationSelectionModal,
            child: Row(
              children: [
                const SizedBox(width: 28),
                Expanded(
                  child: Text(
                    currentLocation,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.ge1,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down, color: AppColors.ge2),
              ],
            ),
          ),
          const SizedBox(height: 16),

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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                );
              },
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
                hintText: 'Search Psychiatrist Doctor',
                hintStyle: const TextStyle(
                  fontSize: 14,
                  color: AppColors.ge2,
                  fontFamily: 'Roboto',
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

 // Upcoming Appointments Section
  Widget _buildUpcomingAppointmentsSection() {
    return Container(
      color: AppColors.bg1,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Upcoming Appointments',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.b1,
              fontFamily: 'Roboto',
            ),
          ),
          const SizedBox(height: 20),

          // Empty State
          Center(
            child: Column(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/home/no_appointments.png',
                      width: 60,
                      height: 60,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'No Upcoming Appointments',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.ge2,
                    fontFamily: 'Roboto',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Looking For Specialist Card
 Widget _buildSpecialistCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.b3,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Looking For\nSpecialist Doctor?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.b1,
                      fontFamily: 'Roboto',
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Tell us what problem you are facing and we will do the Rest!',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.ge2,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const DoctorListScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.b4,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'View All Doctors',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.white,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Image.asset(
              'assets/home/doctor.png',
              width: 100,
              height: 100,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  // Chat with Elphie Card
  Widget _buildElphieCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
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
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/home/mascot.png',
                  width: 80,
                  height: 80,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hello there,\nLorem Ipsum',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.ge1,
                          fontFamily: 'Roboto',
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Navigate your wellness journey with confidence. Ask Elphie for support, answers, or to book an appointment.',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.ge2,
                          fontFamily: 'Roboto',
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AiChatScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.b4,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Chat with Elphie',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.white,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

   // Categories Section
 Widget _buildCategoriesSection() {
     final categories = [
       ("assets/home/Psychiatrist.png", 'Psychiatrist'),
       ("assets/home/Hepatologist.png", 'Hepatologist'),
       ("assets/home/Cardiologist.png", 'Cardiologist'),
       ("assets/home/Dental.png", 'Dental'),
       ("assets/home/Nephrologist.png", 'Nephrologist'),
       ("assets/home/Pulmonologist.png", 'Pulmonologist'),
       ("assets/home/Dermatologist.png", 'Dermatologist'),
       ("assets/home/Gastroenterologist.png", 'Gastroenterologist'),
     ];
 
     return Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Padding(
           padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
           child: const Text(
             'Categories',
             style: TextStyle(
               fontSize: 18,
               fontWeight: FontWeight.w600,
               color: AppColors.b1,
               fontFamily: 'Roboto',
             ),
           ),
         ),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 20),
           child: GridView.builder(
             shrinkWrap: true,
             physics: const NeverScrollableScrollPhysics(),
             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
               crossAxisCount: 4,
               mainAxisSpacing: 12,
               crossAxisSpacing: 12,
               childAspectRatio: 1, // Square aspect ratio
             ),
             itemCount: categories.length,
             itemBuilder: (context, index) {
               final (icon, label) = categories[index];
               return GestureDetector(
                 onTap: () {
                   // Handle category selection
                   print('Selected category: $label');
                 },
                 child: Container(
                   decoration: BoxDecoration(
                     color: AppColors.white,
                     borderRadius: BorderRadius.circular(24), // Squircle shape
                     border: Border.all(
                       color: Color(0xFFE5E7EB), // light-gray border
                       width: 1,
                     ),
                   ),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Container(
                         width: 40,
                         height: 40,
                         margin: const EdgeInsets.only(top: 10, bottom: 6),
                         child: Image.asset(
                           icon,
                           fit: BoxFit.contain,
                         ),
                       ),
                       Flexible(
                         child: Text(
                           label.length > 12 ? '${label.substring(0, 10)}...' : label, // Truncate long names
                           textAlign: TextAlign.center,
                           style: const TextStyle(
                             fontSize: 10,
                             color: Color(0xFF6B7280), // muted gray
                             fontFamily: 'Roboto',
                             fontWeight: FontWeight.w500,
                           ),
                           maxLines: 2,
                           overflow: TextOverflow.ellipsis,
                         ),
                       ),
                     ],
                   ),
                 ),
               );
             },
           ),
         ),
       ],
     );
   }

   // Top Doctors Section
   Widget _buildTopDoctorsSection() {
     return Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Padding(
           padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               const Text(
                 'Top Doctors',
                 style: TextStyle(
                   fontSize: 18,
                   fontWeight: FontWeight.w600,
                   color: AppColors.b1,
                   fontFamily: 'Roboto',
                 ),
               ),
               GestureDetector(
                 onTap: () {
                   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => const DoctorListScreen()),
                   );
                 },
                 child: const Text(
                   'See All',
                   style: TextStyle(
                     fontSize: 13,
                     color: AppColors.b4,
                     fontFamily: 'Roboto',
                     fontWeight: FontWeight.w500,
                   ),
                 ),
               ),
             ],
           ),
         ),
         SizedBox(
           height: 170, // Adjusted height to match the new card design
           child: ListView.builder(
             scrollDirection: Axis.horizontal,
             padding: const EdgeInsets.symmetric(horizontal: 20),
             itemCount: 4,
             itemBuilder: (context, index) {
               // Sample data for demonstration
               final List<Map<String, dynamic>> doctorData = [
                 {
                   'name': 'Dr. Lorem Ipsum',
                   'specialty': 'Physician',
                   'credentials': 'MBBS, MD',
                   'hospital': 'ABC Hospital',
                   'rating': 4.7,
                   'distance': 1.6,
                   'isMale': true,
                 },
                 {
                   'name': 'Dr. Jane Smith',
                   'specialty': 'Cardiologist',
                   'credentials': 'MBBS, MD, DM',
                   'hospital': 'City Heart Center',
                   'rating': 4.9,
                   'distance': 2.3,
                   'isMale': false,
                 },
                 {
                   'name': 'Dr. John Doe',
                   'specialty': 'Neurologist',
                   'credentials': 'MBBS, MD, DM',
                   'hospital': 'Brain Care Institute',
                   'rating': 4.8,
                   'distance': 0.8,
                   'isMale': true,
                 },
                 {
                   'name': 'Dr. Sarah Johnson',
                   'specialty': 'Pediatrician',
                   'credentials': 'MBBS, DCH',
                   'hospital': 'Children Care Hospital',
                   'rating': 4.6,
                   'distance': 1.2,
                   'isMale': false,
                 },
               ];
               
               final doctor = doctorData[index];
               
               return TopDoctorsCard(
                 doctorName: doctor['name'] as String,
                 specialty: doctor['specialty'] as String,
                 credentials: doctor['credentials'] as String,
                 hospital: doctor['hospital'] as String,
                 rating: doctor['rating'] as double,
                 distance: doctor['distance'] as double,
                 isMale: doctor['isMale'] as bool,
                 onViewPressed: () {
                   Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (context) => DoctorProfileScreen(
                         doctorName: doctor['name'] as String,
                         specialty: doctor['specialty'] as String,
                         rating: doctor['rating'] as double,
                         distance: doctor['distance'] as double,
                         isMale: doctor['isMale'] as bool,
                       ),
                     ),
                   );
                 },
               );
             },
           ),
         ),
       ],
     );
   }

  // Services Section
  Widget _buildServicesSection() {
    final services = [
      ("assets/home/clinic_visit.png", 'Clinic Visit'),
      ("assets/home/video_call.png", 'Video Call'),
      ("assets/home/call.png", 'Call'),
      ("assets/home/chat.png", 'Chat'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
          child: const Text(
            'Services',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.b1,
              fontFamily: 'Roboto',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 12,
              crossAxisSpacing: 8,
              childAspectRatio: 0.9,
            ),
            itemCount: services.length,
            itemBuilder: (context, index) {
              final (icon, label) = services[index];
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      icon,
                      width: 40,
                      height: 40,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        label,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppColors.ge1,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
