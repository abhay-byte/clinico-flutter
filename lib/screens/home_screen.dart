import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../components/location_selection_modal.dart';
import '../components/search_filter_modal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentBottomNavIndex = 0;
  String currentLocation = 'New Delhi, India';

  void _showLocationSelectionModal() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => LocationSelectionModal(
        onLocationSelected: () {
          // Handle location selection
          setState(() {
            // Here you would update the current location
            // For demo, keeping the same location
          });
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
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavBar(),
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
              Image.asset(
                'assets/home/location.png',
                width: 20,
                height: 20,
              ),
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
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.ge2,
                ),
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
                  width: 100,
                  height: 100,
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
                    onPressed: () {},
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
              onPressed: () {},
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
      ('assets/home/Psychiatrist.png', 'Psychiatrist'),
      ('assets/home/Hepatologist.png', 'Hepatologist'),
      ('assets/home/Cardiologist.png', 'Cardiologist'),
      ('assets/home/Dental.png', 'Dental'),
      ('assets/home/Nephrologist.png', 'Nephrol...'),
      ('assets/home/Pulmonologist.png', 'Pulmonol...'),
      ('assets/home/Dermatologist.png', 'Dermatol...'),
      ('assets/home/Gastroenterologist.png', 'Gastroen...'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
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
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final (icon, label) = categories[index];
              return Container(
                width: 100,
                margin: const EdgeInsets.only(right: 12),
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
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        label,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 11,
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
                onTap: () {},
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
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: 4,
            itemBuilder: (context, index) {
              return Container(
                width: 200,
                margin: const EdgeInsets.only(right: 12),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: AppColors.b3,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/home/doctor_icon.png',
                                width: 30,
                                height: 30,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Dr. Lorem Ipsum',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.ge1,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  'Physician | MBBS, MD',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: AppColors.ge2,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  'ABC Hospital',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: AppColors.ge2,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/home/location.png',
                                  width: 14,
                                  height: 14,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(width: 4),
                                const Text(
                                  '1.6 Km',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: AppColors.ge2,
                                    fontFamily: 'Roboto',
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(width: 6),
                                Image.asset(
                                  'assets/home/star.png',
                                  width: 14,
                                  height: 14,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(width: 4),
                                const Text(
                                  '4.7',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: AppColors.ge2,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.b4,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              minimumSize: const Size(50, 28),
                            ),
                            child: const Text(
                              'View',
                              style: TextStyle(
                                fontSize: 9,
                                color: AppColors.white,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
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

  // Services Section
  Widget _buildServicesSection() {
    final services = [
      ('assets/home/clinic_visit.png', 'Clinic Visit'),
      ('assets/home/video_call.png', 'Video Call'),
      ('assets/home/call.png', 'Call'),
      ('assets/home/chat.png', 'Chat'),
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

  // Bottom Navigation Bar
  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bg2,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _currentBottomNavIndex,
        onTap: (index) {
          setState(() {
            _currentBottomNavIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.bg2,
        selectedItemColor: AppColors.ge1,
        unselectedItemColor: AppColors.ge2,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/home/home_filled.png',
              width: 24,
              height: 24,
              color: _currentBottomNavIndex == 0
                  ? AppColors.ge1
                  : AppColors.ge2,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/home/messages.png',
              width: 24,
              height: 24,
              color: _currentBottomNavIndex == 1
                  ? AppColors.ge1
                  : AppColors.ge2,
            ),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/home/calender.png',
              width: 24,
              height: 24,
              color: _currentBottomNavIndex == 2
                  ? AppColors.ge1
                  : AppColors.ge2,
            ),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/home/profile.png',
              width: 24,
              height: 24,
              color: _currentBottomNavIndex == 3
                  ? AppColors.ge1
                  : AppColors.ge2,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
