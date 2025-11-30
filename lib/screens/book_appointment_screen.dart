import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants/colors.dart';
import 'home_screen.dart';
import 'date_time_selection_screen.dart';

class BookAppointmentScreen extends StatefulWidget {
  final String doctorName;
  final String doctorSpecialization;
  final String doctorImage;
  final int clinicOpenHour;
  final int clinicCloseHour;

  const BookAppointmentScreen({
    super.key,
    required this.doctorName,
    required this.doctorSpecialization,
    required this.doctorImage,
    this.clinicOpenHour = 10, // Default to 10 AM
    this.clinicCloseHour = 21, // Default to 9 PM
  });

  @override
  _BookAppointmentScreenState createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  String? selectedTime;
  String? selectedDate;
  List<String> timeSlots = [];
  List<String> dates = [];

  // Clinic hours configuration
  late int clinicOpenHour;
  late int clinicCloseHour;

  @override
  void initState() {
    super.initState();
    clinicOpenHour = widget.clinicOpenHour;
    clinicCloseHour = widget.clinicCloseHour;
    _generateDates();
    _generateTimeSlots();
  }

  // Generate dates for the next 14 days
  void _generateDates() {
    List<String> newDates = [];
    DateTime now = DateTime.now();
    
    for (int i = 0; i < 14; i++) {
      DateTime date = DateTime(now.year, now.month, now.day + i);
      
      if (i == 0) {
        newDates.add('Today');
      } else if (i == 1) {
        newDates.add('Tomorrow');
      } else {
        String dayWithSuffix = _getDayWithSuffix(date.day);
        String month = DateFormat('MMM').format(date);
        newDates.add('$dayWithSuffix $month');
      }
    }
    
    setState(() {
      dates = newDates;
    });
  }

  // Generate time slots based on clinic hours and 30-minute intervals
  void _generateTimeSlots() {
    List<String> newTimeSlots = [];
    
    // Check if today is selected to filter out past time slots
    bool isToday = selectedDate == 'Today';
    DateTime now = DateTime.now();
    
    int startHour = clinicOpenHour;
    int endHour = clinicCloseHour;
    
    if (isToday) {
      // If it's today, start from current time
      if (now.hour > endHour) {
        // If current time is past closing time, return empty slots
        setState(() {
          timeSlots = [];
        });
        return;
      }
      
      startHour = now.hour;
      
      // If current time is past the hour but before 30 min, add 30 min slot
      if (now.minute > 0 && now.minute <= 30) {
        String timeString = _formatTime(now.hour, 30);
        if (!_isPastTimeForToday(timeString)) {
          newTimeSlots.add(timeString);
        }
      } else if (now.minute > 30) {
        // If current time is past 30 min, start from next hour
        startHour = now.hour + 1;
      }
    }
    
    // Generate time slots in 30-minute intervals
    for (int hour = startHour; hour <= endHour; hour++) {
      // Add the :00 slot
      if (hour == endHour) {
        // At the end hour, only add the :00 slot
        String timeString = _formatTime(hour, 0);
        if (!_isPastTimeForToday(timeString)) {
          newTimeSlots.add(timeString);
        }
      } else {
        String timeString = _formatTime(hour, 0);
        if (!_isPastTimeForToday(timeString)) {
          newTimeSlots.add(timeString);
        }
        
        // Add the :30 slot
        timeString = _formatTime(hour, 30);
        if (!_isPastTimeForToday(timeString)) {
          newTimeSlots.add(timeString);
        }
      }
    }
    
    setState(() {
      timeSlots = newTimeSlots;
      // If selected time is no longer available, clear it
      if (selectedTime != null && !newTimeSlots.contains(selectedTime)) {
        selectedTime = null;
      }
    });
  }

  // Check if a time slot is in the past when today is selected
  bool _isPastTimeForToday(String timeString) {
    if (selectedDate != 'Today') return false;
    
    DateTime now = DateTime.now();
    List<String> timeParts = timeString.split(' ');
    if (timeParts.length != 2) return false;
    
    String time = timeParts[0];
    String period = timeParts[1];
    
    List<String> hourMinute = time.split(':');
    if (hourMinute.length != 2) return false;
    
    int hour = int.tryParse(hourMinute[0]) ?? 0;
    int minute = int.tryParse(hourMinute[1]) ?? 0;
    
    // Convert to 24-hour format for comparison
    if (period == 'PM' && hour != 12) {
      hour += 12;
    } else if (period == 'AM' && hour == 12) {
      hour = 0;
    }
    
    // Compare hours first
    if (hour < now.hour) {
      return true;
    } else if (hour == now.hour) {
      // If same hour, compare minutes
      return minute <= now.minute;
    }
    
    return false;
  }

  // Format time in 12-hour format with proper padding
  String _formatTime(int hour, int minute) {
    String period = 'AM';
    int displayHour = hour;
    
    if (hour >= 12) {
      period = 'PM';
      if (hour > 12) {
        displayHour = hour - 12;
      } else if (hour == 0 || hour == 24) {
        displayHour = 12;
        period = 'AM';
      }
    } else if (hour == 0) {
      displayHour = 12;
    }
    
    String hourString = displayHour.toString().padLeft(2, '0');
    String minuteString = minute.toString().padLeft(2, '0');
    
    return '$hourString:$minuteString $period';
  }

  // Helper method to add day suffix (st, nd, rd, th) to day numbers
  String _getDayWithSuffix(int day) {
    if (day >= 11 && day <= 13) {
      return '${day}th';
    }
    switch (day % 10) {
      case 1:
        return '${day}st';
      case 2:
        return '${day}nd';
      case 3:
        return '${day}rd';
      default:
        return '${day}th';
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
        title: const Text(
          'Book Appointment',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor Profile Card
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
                    backgroundImage: widget.doctorImage.isNotEmpty 
                        ? AssetImage(widget.doctorImage) 
                        : AssetImage('assets/book_appointment/doctor_logo.png'),
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
                bool isSelected = selectedTime == time;
                return ChoiceChip(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isSelected)
                        Image.asset(
                          'assets/book_appointment/tick.png',
                          width: 14,
                          height: 14,
                          color: Colors.white,
                        ),
                      if (isSelected) const SizedBox(width: 4),
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 14,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  selected: isSelected,
                  selectedColor: AppColors.b4,
                  onSelected: (selected) {
                    setState(() {
                      selectedTime = selected ? time : null;
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: isSelected ? AppColors.b4 : const Color(0xFFE0E0E0),
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
            builder: (context) => const DateTimeSelectionScreen(),
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
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dates.length,
                itemBuilder: (context, index) {
                  String date = dates[index];
                  bool isSelected = selectedDate == date;
                  return Container(
                    margin: EdgeInsets.only(right: index == dates.length - 1 ? 0 : 12),
                    child: ChoiceChip(
                      label: Text(
                        date,
                        style: TextStyle(
                          fontSize: 14,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                      selected: isSelected,
                      selectedColor: AppColors.b4,
                      onSelected: (selected) {
                        setState(() {
                          selectedDate = selected ? date : null;
                          // Regenerate time slots when date changes
                          _generateTimeSlots();
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: isSelected ? AppColors.b4 : const Color(0xFFE0E0E0),
                        ),
                      ),
                      backgroundColor: const Color(0xFFF5F5F5),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                  );
                },
              ),
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

  void _showDateSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Date'),
          content: SizedBox(
            width: double.maxFinite,
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: dates.map((date) {
                bool isSelected = selectedDate == date;
                return ChoiceChip(
                  label: Text(
                    date,
                    style: TextStyle(
                      fontSize: 14,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                  selected: isSelected,
                  selectedColor: AppColors.b4,
                  onSelected: (selected) {
                    setState(() {
                      selectedDate = selected ? date : null;
                      // Regenerate time slots when date changes
                      _generateTimeSlots();
                    });
                    Navigator.pop(context);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: isSelected ? AppColors.b4 : const Color(0xFFE0E0E0),
                    ),
                  ),
                  backgroundColor: const Color(0xFFF5F5F5),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
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
            Image.asset(
              'assets/book_appointment/holding_hands.png',
              width: 100,
              height: 100,
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