import 'package:flutter/material.dart';

class AppointmentSearchPage extends StatefulWidget {
  const AppointmentSearchPage({Key? key}) : super(key: key);

  @override
  State<AppointmentSearchPage> createState() => _AppointmentSearchPageState();
}

class _AppointmentSearchPageState extends State<AppointmentSearchPage>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  List<DoctorMarker> doctors = [];

  @override
  void initState() {
    super.initState();
    // Initialize pulse animation for user location
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (doctors.isEmpty) {
      doctors = _initializeDoctors();
    }
  }

  List<DoctorMarker> _initializeDoctors() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return [
      DoctorMarker(
        id: 1,
        name: 'Dr. Sharma',
        specialty: 'Dermatologist',
        rating: 4.7,
        distance: 1.2,
        area: 'Budella',
        offset: Offset(-screenWidth / 3.5, -screenHeight / 5),
      ),
      DoctorMarker(
        id: 2,
        name: 'Dr. Patel',
        specialty: 'Dermatologist',
        rating: 4.5,
        distance: 2.1,
        area: 'Guru Virjanand Marg',
        offset: Offset(screenWidth / 3.5, -screenHeight / 6),
      ),
      DoctorMarker(
        id: 3,
        name: 'Dr. Kumar',
        specialty: 'Dermatologist',
        rating: 4.2,
        distance: 3.5,
        area: 'Durga Vatika',
        offset: Offset(-screenWidth / 5, screenHeight / 5),
      ),
    ];
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      body: SafeArea(
        child: Stack(
          children: [
            // Map Area with markers
            Positioned.fill(
              child: Stack(
                children: [
                  // Map background (street map simulation)
                  Container(
                    color: Colors.white,
                    child: Stack(
                      children: [
                        // Decorative street/map elements
                        Positioned(
                          left: 40,
                          top: 120,
                          child: Text(
                            'Budella',
                            style: TextStyle(
                              color: Colors.grey[300],
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 120,
                          top: 240,
                          child: Text(
                            'Guru Virjanand Marg',
                            style: TextStyle(
                              color: Colors.grey[300],
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 60,
                          bottom: 140,
                          child: Text(
                            'Durga Vatika',
                            style: TextStyle(
                              color: Colors.grey[300],
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        // User location marker (your_location.png)
                        Center(
                          child: ScaleTransition(
                            scale: Tween<double>(begin: 1.0, end: 1.2).animate(
                              CurvedAnimation(
                                parent: _pulseController,
                                curve: Curves.easeInOut,
                              ),
                            ),
                            child: Image.asset(
                              'assets/ai_chat/your_location.png',
                              width: 56,
                              height: 56,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        // Doctor markers
                        ...doctors.map((doctor) {
                          return Positioned(
                            left:
                                MediaQuery.of(context).size.width / 2 +
                                doctor.offset.dx,
                            top:
                                MediaQuery.of(context).size.height / 2 +
                                doctor.offset.dy,
                            child: GestureDetector(
                              onTap: () => _showDoctorInfo(doctor),
                              child: Image.asset(
                                'assets/ai_chat/doctor_location.png',
                                width: 48,
                                height: 48,
                                fit: BoxFit.contain,
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Header and Search Bar (overlay)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [const SizedBox(height: 12), _SearchBar()],
            ),
            // Bottom navigation/action bar (white overlay with handle)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: Center(
                  child: Container(
                    width: 44,
                    height: 5,
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDoctorInfo(DoctorMarker doctor) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/ai_chat/doctor_location.png',
                  width: 40,
                  height: 40,
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
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        doctor.specialty,
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          doctor.rating.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Text(
                      '${doctor.distance} km',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              doctor.area,
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF248BEB),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Booking ${doctor.name}...')),
                  );
                },
                child: const Text(
                  'Book Appointment',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
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
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Dermatologist Near me',
                  hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                ),
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
}

// Doctor marker data model
class DoctorMarker {
  final int id;
  final String name;
  final String specialty;
  final double rating;
  final double distance;
  final String area;
  final Offset offset;

  DoctorMarker({
    required this.id,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.distance,
    required this.area,
    required this.offset,
  });
}
