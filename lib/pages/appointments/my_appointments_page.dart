import 'package:flutter/material.dart';

class MyAppointmentsPage extends StatefulWidget {
  @override
  _MyAppointmentsPageState createState() => _MyAppointmentsPageState();
}

class _MyAppointmentsPageState extends State<MyAppointmentsPage> {
  // Sample appointment data
  final List<Appointment> _allAppointments = [
    // Upcoming Appointments
    Appointment(
      id: '1',
      doctorName: 'Dr. Lorem Ipsum',
      specialty: 'General Physician',
      appointmentDate: DateTime(2025, 11, 12),
      appointmentTime: '10:30 AM',
      appointmentType: 'in-person',
      location: 'Lorem Clinic, Delhi',
      status: 'upcoming',
    ),
    Appointment(
      id: '2',
      doctorName: 'Dr. Dolor Sit',
      specialty: 'Cardiologist',
      appointmentDate: DateTime(2025, 11, 15),
      appointmentTime: '02:00 PM',
      appointmentType: 'video',
      location: 'Online Consultation',
      status: 'upcoming',
    ),
    Appointment(
      id: '3',
      doctorName: 'Dr. Consectetur Elit',
      specialty: 'Dermatologist',
      appointmentDate: DateTime(2025, 1, 18),
      appointmentTime: '11:00 AM',
      appointmentType: 'follow-up',
      location: 'Adipiscing Medical Center, Bangalore',
      status: 'upcoming',
    ),
    // Past Appointments
    Appointment(
      id: '4',
      doctorName: 'Dr. Tempor Incidunt',
      specialty: 'Orthopedic',
      appointmentDate: DateTime(2025, 11, 5),
      appointmentTime: '09:00 AM',
      appointmentType: 'in-person',
      location: 'Labore Clinic, Mumbai',
      status: 'attended',
    ),
    Appointment(
      id: '5',
      doctorName: 'Dr. Magna Aliqua',
      specialty: 'ENT Specialist',
      appointmentDate: DateTime(2025, 10, 28),
      appointmentTime: '03:30 PM',
      appointmentType: 'video',
      location: 'Online Consultation',
      status: 'attended',
    ),
    Appointment(
      id: '6',
      doctorName: 'Dr. Enim Minim',
      specialty: 'Neurologist',
      appointmentDate: DateTime(2025, 10, 20),
      appointmentTime: '04:00 PM',
      appointmentType: 'in-person',
      location: 'Veniam Hospital, Delhi',
      status: 'not_attended',
    ),
    // Cancelled Appointment
    Appointment(
      id: '7',
      doctorName: 'Dr. Quis Nostrud',
      specialty: 'Pediatrician',
      appointmentDate: DateTime(2025, 10, 15),
      appointmentTime: '11:30 AM',
      appointmentType: 'follow-up',
      location: 'Exercitation Clinic, Pune',
      status: 'cancelled',
    ),
  ];

  // State variables
  String _searchQuery = '';
  String _selectedTab = 'all'; // 'all', 'upcoming', 'past', 'cancelled'
  bool _sortNewestFirst = true; // true for newest first, false for oldest first
  List<Appointment> _filteredAppointments = [];

  @override
  void initState() {
    super.initState();
    _filteredAppointments = List.from(_allAppointments);
    _applyFilters();
  }

  void _applyFilters() {
    List<Appointment> results = List.from(_allAppointments);

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      results = results.where((appointment) {
        return appointment.doctorName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            appointment.specialty.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            appointment.location.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            '${appointment.appointmentDate.day} ${_getMonthName(appointment.appointmentDate.month)} ${appointment.appointmentDate.year}'.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    // Apply tab filter
    if (_selectedTab != 'all') {
      if (_selectedTab == 'upcoming') {
        results = results.where((appointment) => appointment.status == 'upcoming').toList();
      } else if (_selectedTab == 'past') {
        results = results.where((appointment) => appointment.status == 'attended' || appointment.status == 'not_attended').toList();
      } else if (_selectedTab == 'cancelled') {
        results = results.where((appointment) => appointment.status == 'cancelled').toList();
      }
    }

    // Apply sorting
    results.sort((a, b) {
      if (_sortNewestFirst) {
        // Sort by date descending (newest first)
        int dateCompare = b.appointmentDate.compareTo(a.appointmentDate);
        if (dateCompare != 0) return dateCompare;
        // If dates are same, sort by time
        return b.appointmentTime.compareTo(a.appointmentTime);
      } else {
        // Sort by date ascending (oldest first)
        int dateCompare = a.appointmentDate.compareTo(b.appointmentDate);
        if (dateCompare != 0) return dateCompare;
        // If dates are same, sort by time
        return a.appointmentTime.compareTo(b.appointmentTime);
      }
    });

    setState(() {
      _filteredAppointments = results;
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
    _applyFilters();
  }

  void _onTabChanged(String tab) {
    setState(() {
      _selectedTab = tab;
    });
    _applyFilters();
  }

  void _toggleSortOrder() {
    setState(() {
      _sortNewestFirst = !_sortNewestFirst;
    });
    _applyFilters();
  }

  String _getMonthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }

  String _getStatusDisplayText(String status) {
    switch (status) {
      case 'upcoming':
        return 'Upcoming';
      case 'attended':
        return 'Attended';
      case 'not_attended':
        return 'Not Attended';
      case 'cancelled':
        return 'Cancelled';
      default:
        return status;
    }
  }

  Color _getStatusBackgroundColor(String status) {
    switch (status) {
      case 'upcoming':
        return Color(0xFFC8E6A0); // light green
      case 'attended':
        return Color(0xFFDBEAFE); // light blue
      case 'not_attended':
        return Color(0xFFFEE2E2); // light red
      case 'cancelled':
        return Color(0xFFFEF3C7); // light yellow/orange
      default:
        return Color(0xFFE5E7EB); // default gray
    }
  }

  Color _getStatusTextColor(String status) {
    switch (status) {
      case 'upcoming':
        return Color(0xFF2F4F1F); // dark green
      case 'attended':
        return Color(0xFF1E40AF); // dark blue
      case 'not_attended':
        return Color(0xFFD97706); // dark orange
      case 'cancelled':
        return Color(0xFFDC2626); // dark red
      default:
        return Color(0xFF101828); // default dark
    }
  }

  IconData _getAppointmentTypeIcon(String type) {
    switch (type) {
      case 'in-person':
        return Icons.person;
      case 'video':
        return Icons.videocam;
      case 'follow-up':
        return Icons.refresh;
      default:
        return Icons.person;
    }
  }

  Color _getAppointmentTypeIconColor(String type) {
    switch (type) {
      case 'in-person':
        return Color(0xFF174880); // primary blue
      case 'video':
        return Color(0xFF10B981); // green
      case 'follow-up':
        return Color(0xFFF59E0B); // amber
      default:
        return Color(0xFF174880); // primary blue
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEBF1FA), // background color
      body: RefreshIndicator(
        onRefresh: () async {
          // Simulate refresh
          await Future.delayed(Duration(seconds: 1));
          _applyFilters();
        },
        child: CustomScrollView(
          slivers: [
            // Title Section (without blue background)
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.only(top: 100, left: 16, right: 16, bottom: 16),
                color: Color(0xFFEBF1FA), // background color
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "My Appointments",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF174880), // b1 color
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "${_filteredAppointments.length} total appointments",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF174880).withOpacity(0.7), // b1 color with 70% opacity
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Search Bar
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: Color(0xFFEBF1FA), // background color
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF), // white
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(12),
                        child: Image.asset(
                          'assets/home/search.png',
                          width: 20,
                          height: 20,
                          color: Color(0xFF6B7280), // ge2 color
                        ),
                      ),
                      hintText: 'Search by doctor, specialty, or date',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF6B7280), // ge2 color
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    style: TextStyle(color: Color(0xFF101828)), // dark text
                    cursorColor: Color(0xFF174880), // primary blue
                    onChanged: _onSearchChanged,
                  ),
                ),
              ),
            ),
            
            // Filter Bar
            SliverToBoxAdapter(
              child: Container(
                height: 56,
                padding: EdgeInsets.symmetric(horizontal: 16),
                color: Color(0xFFEBF1FA), // background color
                child: Row(
                  children: [
                    // Tab Filters (Left side - Pills/Chips)
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildTabFilter('All', 'all'),
                            SizedBox(width: 8),
                            _buildTabFilter('Upcoming', 'upcoming'),
                            SizedBox(width: 8),
                            _buildTabFilter('Past', 'past'),
                            SizedBox(width: 8),
                            _buildTabFilter('Cancelled', 'cancelled'),
                          ],
                        ),
                      ),
                    ),
                    
                    // Sort Button (Right side)
                    Row(
                      children: [
                        InkWell(
                          onTap: _toggleSortOrder,
                          child: Container(
                            width: 36,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Color(0xFFF3F4F6), // light gray
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.filter_list,
                              size: 20,
                              color: Color(0xFF6B7280), // medium gray
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        InkWell(
                          onTap: _toggleSortOrder,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    _sortNewestFirst ? "Newest → Oldest" : "Oldest → Newest",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF6B7280), // medium gray
                                    ),
                                  ),
                                  Icon(
                                    Icons.expand_more,
                                    size: 16,
                                    color: Color(0xFF6B7280), // medium gray
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            // Content Area with Appointment Cards - Grouped by Status
            if (_selectedTab == 'all') ...[
              // Upcoming Appointments Section
              if (_getAppointmentsByStatus('upcoming').isNotEmpty)
                _buildSectionHeader('Upcoming Appointments', _getAppointmentsByStatus('upcoming').length, Color(0xFFC8E6A0)),
              if (_getAppointmentsByStatus('upcoming').isNotEmpty)
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        Appointment appointment = _getAppointmentsByStatus('upcoming')[index];
                        return AppointmentCard(
                          appointment: appointment,
                          onTap: () {
                            // Navigate to appointment details page
                            // For now, just show a snackbar
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Navigating to appointment details for ${appointment.doctorName}'),
                              ),
                            );
                          },
                        );
                      },
                      childCount: _getAppointmentsByStatus('upcoming').length,
                    ),
                  ),
                ),
              
              // Past Appointments Section (Attended + Not Attended)
              if (_getAppointmentsByStatus('attended').isNotEmpty || _getAppointmentsByStatus('not_attended').isNotEmpty)
                _buildSectionHeader('Past Appointments',
                  _getAppointmentsByStatus('attended').length + _getAppointmentsByStatus('not_attended').length,
                  Color(0xFFDBEAFE)),
              if (_getAppointmentsByStatus('attended').isNotEmpty || _getAppointmentsByStatus('not_attended').isNotEmpty)
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        // Combine attended and not_attended appointments
                        List<Appointment> pastAppointments = [
                          ..._getAppointmentsByStatus('attended'),
                          ..._getAppointmentsByStatus('not_attended')
                        ];
                        // Sort by date descending
                        pastAppointments.sort((a, b) => b.appointmentDate.compareTo(a.appointmentDate));
                        
                        Appointment appointment = pastAppointments[index];
                        return AppointmentCard(
                          appointment: appointment,
                          onTap: () {
                            // Navigate to appointment details page
                            // For now, just show a snackbar
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Navigating to appointment details for ${appointment.doctorName}'),
                              ),
                            );
                          },
                        );
                      },
                      childCount: _getAppointmentsByStatus('attended').length + _getAppointmentsByStatus('not_attended').length,
                    ),
                  ),
                ),
              
              // Cancelled Appointments Section
              if (_getAppointmentsByStatus('cancelled').isNotEmpty)
                _buildSectionHeader('Cancelled Appointments', _getAppointmentsByStatus('cancelled').length, Color(0xFFFEE2E2)),
              if (_getAppointmentsByStatus('cancelled').isNotEmpty)
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        Appointment appointment = _getAppointmentsByStatus('cancelled')[index];
                        return AppointmentCard(
                          appointment: appointment,
                          onTap: () {
                            // Navigate to appointment details page
                            // For now, just show a snackbar
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Navigating to appointment details for ${appointment.doctorName}'),
                              ),
                            );
                          },
                        );
                      },
                      childCount: _getAppointmentsByStatus('cancelled').length,
                    ),
                  ),
                ),
            ] else ...[
              // For other tabs (upcoming, past, cancelled), show flat list
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index >= _filteredAppointments.length) {
                        return null;
                      }
                      
                      Appointment appointment = _filteredAppointments[index];
                      return AppointmentCard(
                        appointment: appointment,
                        onTap: () {
                          // Navigate to appointment details page
                          // For now, just show a snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Navigating to appointment details for ${appointment.doctorName}'),
                            ),
                          );
                        },
                      );
                    },
                    childCount: _filteredAppointments.isEmpty ? 1 : _filteredAppointments.length,
                  ),
                ),
              ),
            ],
            
            // Empty state if no appointments match filters
            if (_filteredAppointments.isEmpty)
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  margin: EdgeInsets.only(top: 60),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Icon(
                        Icons.event_busy,
                        size: 80,
                        color: Color(0xFFCBD5E1), // light gray
                      ),
                      SizedBox(height: 20),
                      Text(
                        "No Appointments Found",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF6B7280), // medium gray
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "You don't have any appointments matching this filter.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF9CA3AF), // light gray
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 24),
                      Container(
                        height: 44,
                        decoration: BoxDecoration(
                          color: Color(0xFF174880), // primary blue
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(22),
                            onTap: () {
                              // Navigate to book appointment page
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Navigate to book appointment page'),
                                ),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: Center(
                                child: Text(
                                  "Book Appointment",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFFFFFFF), // white
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          
          // Bottom padding to prevent content from being cut off by bottom navigation
          SliverToBoxAdapter(
            child: SizedBox(height: 80),
          ),
        ],
      ),
    );
  }

  // Helper method to get appointments by status
  List<Appointment> _getAppointmentsByStatus(String status) {
    return _filteredAppointments.where((appointment) => appointment.status == status).toList();
  }

  // Helper method to build section header
  Widget _buildSectionHeader(String title, int count, Color badgeColor) {
    return SliverToBoxAdapter(
      child: Container(
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Icon(
              Icons.event_available, // Using event_available icon
              size: 18,
              color: Color(0xFF174880), // Primary blue
            ),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF101828), // Dark text
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: badgeColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$count',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _getStatusTextColor(
                    title.contains('Upcoming') ? 'upcoming' :
                    title.contains('Past') ? 'attended' : 'cancelled'
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabFilter(String label, String value) {
    int count = 0;
    
    switch (value) {
      case 'all':
        count = _allAppointments.length;
        break;
      case 'upcoming':
        count = _allAppointments.where((a) => a.status == 'upcoming').length;
        break;
      case 'past':
        count = _allAppointments.where((a) => a.status == 'attended' || a.status == 'not_attended').length;
        break;
      case 'cancelled':
        count = _allAppointments.where((a) => a.status == 'cancelled').length;
        break;
    }

    bool isActive = _selectedTab == value;
    
    return InkWell(
      onTap: () => _onTabChanged(value),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 32,
        decoration: BoxDecoration(
          color: isActive ? Color(0xFF174880) : Color(0xFFF3F4F6), // primary blue or light gray
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                color: isActive ? Color(0xFFFFFFFF) : Color(0xFF6B7280), // white or medium gray
              ),
            ),
            if (count > 0) ...[
              SizedBox(width: 6),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                decoration: BoxDecoration(
                  color: _getStatusBackgroundColor(
                    value == 'upcoming' ? 'upcoming' : 
                    value == 'past' ? 'attended' : 
                    value == 'cancelled' ? 'cancelled' : 'upcoming'
                  ),
                  borderRadius: BorderRadius.circular(9), // circular badge
                ),
                child: Text(
                  count.toString(),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: _getStatusTextColor(
                      value == 'upcoming' ? 'upcoming' : 
                      value == 'past' ? 'attended' : 
                      value == 'cancelled' ? 'cancelled' : 'upcoming'
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Appointment data model
class Appointment {
  final String id;
  final String doctorName;
  final String specialty;
  final DateTime appointmentDate;
  final String appointmentTime;
  final String appointmentType; // "in-person", "video", "follow-up"
  final String location; // Clinic/Hospital name
  final String status; // "upcoming", "attended", "not_attended", "cancelled"
  final String? notes;

  Appointment({
    required this.id,
    required this.doctorName,
    required this.specialty,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.appointmentType,
    required this.location,
    required this.status,
    this.notes,
  });
}

// Appointment Card Widget
class AppointmentCard extends StatelessWidget {
  final Appointment appointment;
  final VoidCallback? onTap;

  const AppointmentCard({
    Key? key,
    required this.appointment,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color statusBackgroundColor = _getStatusBackgroundColor(appointment.status);
    Color statusTextColor = _getStatusTextColor(appointment.status);
    IconData appointmentTypeIcon = _getAppointmentTypeIcon(appointment.appointmentType);
    Color appointmentTypeIconColor = _getAppointmentTypeIconColor(appointment.appointmentType);

    return Container(
      margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF), // white
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0x0D0000), // 5% opacity black
            offset: Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Doctor Info + Status Badge
            Row(
              children: [
                // Left Side - Doctor Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointment.doctorName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF101828), // dark text
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        appointment.specialty,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF6B7280), // medium gray
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Right Side - Status Badge
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: statusBackgroundColor,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    _getStatusDisplayText(appointment.status),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: statusTextColor,
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 16),
            
            // Divider Line
            Container(
              height: 1,
              color: Color(0xFFE5E7EB), // light gray
            ),
            
            SizedBox(height: 16),
            
            // Details Section
            _buildDetailRow(Icons.calendar_month, 
              '${appointment.appointmentDate.day} ${_getMonthName(appointment.appointmentDate.month)} ${appointment.appointmentDate.year}'),
            SizedBox(height: 10),
            _buildDetailRow(Icons.access_time, appointment.appointmentTime),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  appointmentTypeIcon,
                  size: 16,
                  color: appointmentTypeIconColor,
                ),
                SizedBox(width: 12),
                Text(
                  appointment.appointmentType == 'in-person' ? 'In-person' : 
                  appointment.appointmentType == 'video' ? 'Video' : 
                  'Follow-up',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF374151), // medium dark gray
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  appointment.appointmentType == 'in-person' ? Icons.location_on : Icons.local_hospital,
                  size: 16,
                  color: Color(0xFF6B7280), // medium gray
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    appointment.location,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF374151), // medium dark gray
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Color(0xFF6B7280), // medium gray
        ),
        SizedBox(width: 12),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF374151), // medium dark gray
          ),
        ),
      ],
    );
  }

  String _getStatusDisplayText(String status) {
    switch (status) {
      case 'upcoming':
        return 'Upcoming';
      case 'attended':
        return 'Attended';
      case 'not_attended':
        return 'Not Attended';
      case 'cancelled':
        return 'Cancelled';
      default:
        return status;
    }
  }

  Color _getStatusBackgroundColor(String status) {
    switch (status) {
      case 'upcoming':
        return Color(0xFFC8E6A0); // light green
      case 'attended':
        return Color(0xFFDBEAFE); // light blue
      case 'not_attended':
        return Color(0xFFFEE2E2); // light red
      case 'cancelled':
        return Color(0xFFFEF3C7); // light yellow/orange
      default:
        return Color(0xFFE5E7EB); // default gray
    }
  }

  Color _getStatusTextColor(String status) {
    switch (status) {
      case 'upcoming':
        return Color(0xFF2F4F1F); // dark green
      case 'attended':
        return Color(0xFF1E40AF); // dark blue
      case 'not_attended':
        return Color(0xFFD97706); // dark orange
      case 'cancelled':
        return Color(0xFFDC2626); // dark red
      default:
        return Color(0xFF101828); // default dark
    }
  }

  IconData _getAppointmentTypeIcon(String type) {
    switch (type) {
      case 'in-person':
        return Icons.person;
      case 'video':
        return Icons.videocam;
      case 'follow-up':
        return Icons.refresh;
      default:
        return Icons.person;
    }
  }

  Color _getAppointmentTypeIconColor(String type) {
    switch (type) {
      case 'in-person':
        return Color(0xFF174880); // primary blue
      case 'video':
        return Color(0xFF10B981); // green
      case 'follow-up':
        return Color(0xFFF59E0B); // amber
      default:
        return Color(0xFF174880); // primary blue
    }
  }

  String _getMonthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }
}