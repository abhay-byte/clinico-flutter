import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'date_time_selection_screen.dart';
import 'home_screen.dart';

class BookAppointmentScreen extends StatefulWidget {
  final String doctorName;
  final String doctorSpecialization;
  final String doctorImage;

  const BookAppointmentScreen({
    super.key,
    required this.doctorName,
    required this.doctorSpecialization,
    required this.doctorImage,
  });

  @override
  _BookAppointmentScreenState createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  String? selectedTime;
 String? selectedDate;

  // Sample time slots
  final List<String> timeSlots = [
    '10:0 AM',
    '10:30 AM',
    '11:00 AM',
    '11:30 AM',
    '12:00 PM',
    '12:30 PM',
    '2:00 PM',
    '2:30 PM',
    '3:00 PM',
    '3:30 PM',
    '4:00 PM',
    '4:30 PM',
  ];

  // Sample dates
  final List<String> dates = [
    'Tomorrow',
    '17th Nov',
    '18th Nov',
    '19th Nov',
    '20th Nov',
    '21st Nov',
 ];

  DateTime? _getDateFromDateString(String dateString) {
    // Parse the date string to extract day and month
    // For example, "17th Nov" -> DateTime with day 17 and month 11
    try {
      // Split the string to get day and month
      List<String> parts = dateString.split(' ');
      if (parts.length >= 2) {
        // Extract day number by removing "th", "st", "nd", "rd" suffixes
        String dayString = parts[0].replaceAll(RegExp(r'[^\d]'), '');
        int day = int.tryParse(dayString) ?? 0;
        
        // Get current year and month
        DateTime now = DateTime.now();
        int currentYear = now.year;
        int currentMonth = now.month;
        
        // Simple mapping for month names
        int month = _getMonthNumber(parts[1]);
        
        // If the month has already passed this year, use next year
        if (month < currentMonth) {
          currentYear++;
        }
        
        return DateTime(currentYear, month, day);
      }
    } catch (e) {
      print('Error parsing date string: $e');
    }
    return null;
  }

  int _getMonthNumber(String monthName) {
    switch (monthName.toLowerCase()) {
      case 'jan': return 1;
      case 'feb': return 2;
      case 'mar': return 3;
      case 'apr': return 4;
      case 'may': return 5;
      case 'jun': return 6;
      case 'jul': return 7;
      case 'aug': return 8;
      case 'sep': return 9;
      case 'oct': return 10;
      case 'nov': return 11;
      case 'dec': return 12;
      default: return DateTime.now().month;
    }
  }

 String _getMonthName(int month) {
    switch (month) {
      case 1: return 'Jan';
      case 2: return 'Feb';
      case 3: return 'Mar';
      case 4: return 'Apr';
      case 5: return 'May';
      case 6: return 'Jun';
      case 7: return 'Jul';
      case 8: return 'Aug';
      case 9: return 'Sep';
      case 10: return 'Oct';
      case 11: return 'Nov';
      case 12: return 'Dec';
      default: return 'Jan';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset(
            'assets/book_appointment/back.png',
            width: 24,
            height: 24,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor Summary Header
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/book_appointment/doctor_logo.png'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.doctorName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.doctorSpecialization,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Time Slot Selection
            const Text(
              'Select Time Slot',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12.0,
              runSpacing: 12.0,
              children: timeSlots.map((time) {
                return ChoiceChip(
                  label: Text(
                    time,
                    style: TextStyle(
                      fontSize: 14,
                      color: selectedTime == time ? Colors.white : Colors.black,
                    ),
                  ),
                  selected: selectedTime == time,
                  selectedColor: AppColors.b4,
                  onSelected: (selected) {
                    setState(() {
                      selectedTime = selected ? time : null;
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: selectedTime == time
                          ? AppColors.b4
                          : const Color(0xFFE0E0E0),
                    ),
                  ),
                  backgroundColor: const Color(0xFFF5F5F5),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Date Selection
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Select Date',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DateTimeSelectionScreen(
                          preselectedDate: selectedDate != null
                              ? _getDateFromDateString(selectedDate!)
                              : null,
                          preselectedTime: selectedTime,
                          onDateTimeSelected: (date, time) {
                            setState(() {
                              selectedDate = '${date.day}th ${_getMonthName(date.month)}';
                              selectedTime = time;
                            });
                          },
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'View All',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.b4,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12.0,
              runSpacing: 12.0,
              children: dates.map((date) {
                return ChoiceChip(
                  label: Text(
                    date,
                    style: TextStyle(
                      fontSize: 14,
                      color: selectedDate == date ? Colors.white : Colors.black,
                    ),
                  ),
                  selected: selectedDate == date,
                  selectedColor: AppColors.b4,
                  onSelected: (selected) {
                    setState(() {
                      selectedDate = selected ? date : null;
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: selectedDate == date
                          ? AppColors.b4
                          : const Color(0xFFE0E0E0),
                    ),
                  ),
                  backgroundColor: const Color(0xFFF5F5F5),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Note Text Block
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Note:- You will get a call from the doctor in app, on your appointment date and specified time.',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Confirm Appointment Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedTime == null || selectedDate == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select both time and date'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    // Simulate booking API call
                    // Navigate to Appointment Confirmation Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AppointmentConfirmationScreen(),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.b4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Confirm Appointment',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppointmentConfirmationScreen extends StatelessWidget {
  const AppointmentConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              size: 100,
              color: Colors.green,
            ),
            const SizedBox(height: 24),
            const Text(
              'Appointment Confirmed!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Your appointment has been booked successfully',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 200,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.b4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Go to Home',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}