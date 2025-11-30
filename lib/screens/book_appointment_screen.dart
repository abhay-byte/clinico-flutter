import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants/colors.dart';
import 'home_screen.dart';
import 'date_time_selection_screen.dart';
import '../models/working_hours_model.dart';

class BookAppointmentScreen extends StatefulWidget {
  final String doctorName;
  final String doctorSpecialization;
  final String doctorImage;
  final List<WorkingHours> workingHours;

  const BookAppointmentScreen({
    super.key,
    required this.doctorName,
    required this.doctorSpecialization,
    required this.doctorImage,
    this.workingHours = const [],
  });

  @override
  _BookAppointmentScreenState createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  String? selectedTime;
  String? selectedDate;
  List<String> timeSlots = [];
  List<String> dates = [];

  @override
  void initState() {
    super.initState();
    _generateDates();
    _generateTimeSlots();
  }

  // Check if two dates are the same day
  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.day == date2.day &&
        date1.month == date2.month &&
        date1.year == date2.year;
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

  // Generate time slots based on working hours and 30-minute intervals
  void _generateTimeSlots() {
    List<String> newTimeSlots = [];
    
    // Check if today is selected to filter out past time slots
    bool isToday = selectedDate == 'Today';
    DateTime now = DateTime.now();
    
    // Determine the date for which we're generating slots
    DateTime targetDate = _getDateForSelection(selectedDate);
    
    // Get working hours for the selected date
    List<WorkingHours> dayWorkingHours = _getWorkingHoursForDate(targetDate);
    
    for (WorkingHours hours in dayWorkingHours) {
      int startHour = WorkingHours.parseTimeToHours(hours.startTime);
      int startMinute = int.tryParse(hours.startTime.split(':')[1].replaceAll(RegExp(r'[aApPmM]'), '')) ?? 0;
      int endHour = WorkingHours.parseTimeToHours(hours.endTime);
      int endMinute = int.tryParse(hours.endTime.split(':')[1].replaceAll(RegExp(r'[aApPmM]'), '')) ?? 0;
      
      // If it's today and the working hours have already passed, skip
      if (isToday) {
        int currentTimeInMinutes = now.hour * 60 + now.minute;
        int workingStartInMinutes = startHour * 60 + startMinute;
        int workingEndInMinutes = endHour * 60 + endMinute;
        
        // If the working hours have already ended today, skip
        if (currentTimeInMinutes >= workingEndInMinutes) {
          continue;
        }
        
        // If the working hours haven't started yet today, start from the working hour
        if (currentTimeInMinutes < workingStartInMinutes) {
          // Generate slots from working start time
          _addTimeSlotsInRange(startHour, startMinute, endHour, endMinute, newTimeSlots, isToday, now);
        } else {
          // Generate slots from current time within the working hours
          _addTimeSlotsFromCurrentTime(startHour, startMinute, endHour, endMinute, newTimeSlots, now);
        }
      } else {
        // For future dates, generate all slots within the working hours
        _addTimeSlotsInRange(startHour, startMinute, endHour, endMinute, newTimeSlots, isToday, now);
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
      backgroundColor: const Color(0xFFF6F8FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F8FB),
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
            color: Color(0xFF2F80ED),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor Profile Card
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey[300]!,
                        width: 1.0,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 29,
                      backgroundColor: Colors.grey[200],
                      backgroundImage: widget.doctorImage.isNotEmpty
                          ? AssetImage(widget.doctorImage)
                          : AssetImage('assets/book_appointment/doctor_logo.png'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dr. ${widget.doctorName}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${widget.doctorSpecialization} | MBBS, MD | AB...',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Languages - Hindi, English',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Color(0xFF2F80ED),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Volunteer',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Time Slot Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Time Slot',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _handleViewAllPressed();
                  },
                  child: const Text(
                    'View all',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
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
                itemCount: timeSlots.length,
                itemBuilder: (context, index) {
                  String time = timeSlots[index];
                  bool isSelected = selectedTime == time;
                  
                  return Container(
                    margin: EdgeInsets.only(right: index == timeSlots.length - 1 ? 0 : 12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF2F80ED) : Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: !isSelected ? [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ] : null,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          // Check if this is today and the time has already passed
                          if (selectedDate == 'Today') {
                            if (_isPastTimeForToday(time)) {
                              return; // Don't allow selecting past times
                            }
                          }
                          setState(() {
                            selectedTime = isSelected ? null : time;
                          });
                        },
                        child: Center(
                          child: Text(
                            time,
                            style: TextStyle(
                              fontSize: 14,
                              color: isSelected ? Colors.white : Colors.black,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Date',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _handleViewAllPressed();
                  },
                  child: const Text(
                    'View all',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
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
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF2F80ED) : Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: !isSelected ? [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ] : null,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDate = isSelected ? null : date;
                            // Regenerate time slots when date changes
                            _generateTimeSlots();
                          });
                        },
                        child: Center(
                          child: Text(
                            date,
                            style: TextStyle(
                              fontSize: 14,
                              color: isSelected ? Colors.white : Colors.black,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            const SizedBox(height: 20),

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
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Confirm Appointment Button
            SizedBox(
              width: double.infinity,
              height: 50,
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
                  backgroundColor: const Color(0xFF2F80ED),
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
                    borderRadius: BorderRadius.circular(30),
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

  // Helper method to get the actual date for the selected date string
  DateTime _getDateForSelection(String? dateSelection) {
    if (dateSelection == null) return DateTime.now();
    
    if (dateSelection == 'Today') {
      return DateTime.now();
    } else if (dateSelection == 'Tomorrow') {
      return DateTime.now().add(Duration(days: 1));
    } else {
      // Parse the date string in format like "1st Jan", "2nd Feb", etc.
      // This is a simplified version - in a real app you'd need more robust parsing
      DateTime now = DateTime.now();
      
      // Try to parse the format "1st Jan", "2nd Feb", etc.
      try {
        // Extract day and month from the format "1st Jan"
        List<String> parts = dateSelection.split(' ');
        if (parts.length == 2) {
          String dayWithSuffix = parts[0];
          String month = parts[1];
          
          // Extract numeric day from "1st", "2nd", "3rd", "4th", etc.
          String dayString = dayWithSuffix.replaceAll(RegExp(r'[^\d]'), '');
          int day = int.tryParse(dayString) ?? 1;
          
          // Find the month number
          int monthNumber = _getMonthNumber(month);
          
          // Create the date in the current year
          return DateTime(now.year, monthNumber, day);
        }
      } catch (e) {
        // If parsing fails, return a default date
        return DateTime(now.year, now.month, now.day + 2);
      }
      
      // If parsing fails, return a default date
      return DateTime(now.year, now.month, now.day + 2);
    }
  }
  
  // Helper method to get month number from month name
  int _getMonthNumber(String monthName) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    
    for (int i = 0; i < months.length; i++) {
      if (months[i] == monthName) {
        return i + 1;
      }
    }
    
    return 1; // Default to January if month not found
  }

  // Helper method to get working hours for a specific date
  List<WorkingHours> _getWorkingHoursForDate(DateTime date) {
    // Map weekday to string name
    String dayName = _getDayName(date);
    return widget.workingHours.where((hour) => hour.day.toLowerCase() == dayName.toLowerCase()).toList();
  }

  String _getDayName(DateTime date) {
    switch (date.weekday) {
      case 1: return 'monday';
      case 2: return 'tuesday';
      case 3: return 'wednesday';
      case 4: return 'thursday';
      case 5: return 'friday';
      case 6: return 'saturday';
      case 7: return 'sunday';
      default: return '';
    }
  }

  // Helper method to handle the View All button press
 void _handleViewAllPressed() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DateTimeSelectionScreen(
          workingHours: widget.workingHours,
        ),
      ),
    );
    
    if (result != null) {
      // Update selected date and time based on the result
      DateTime selectedDateTime = result['date'];
      String selectedTimeString = result['time'];
      
      // Update the selected date in the UI
      String dateDisplay = '';
      bool isToday = _isSameDay(selectedDateTime, DateTime.now());
      bool isTomorrow = _isSameDay(selectedDateTime, DateTime.now().add(const Duration(days: 1)));
      
      if (isToday) {
        dateDisplay = 'Today';
      } else if (isTomorrow) {
        dateDisplay = 'Tomorrow';
      } else {
        String dayWithSuffix = _getDayWithSuffix(selectedDateTime.day);
        String month = DateFormat('MMM').format(selectedDateTime);
        dateDisplay = '$dayWithSuffix $month';
      }
      
      setState(() {
        selectedDate = dateDisplay;
        selectedTime = selectedTimeString;
      });
      
      // Regenerate time slots based on the selected date
      _generateTimeSlots();
    }
 }

  // Helper method to add time slots in a specific range
 void _addTimeSlotsInRange(int startHour, int startMinute, int endHour, int endMinute, List<String> timeSlots, bool isToday, DateTime now) {
    int currentHour = startHour;
    int currentMinute = startMinute;
    
    while (currentHour < endHour || (currentHour == endHour && currentMinute < endMinute)) {
      String timeString = _formatTime(currentHour, currentMinute);
      
      // If it's today, check if the time has already passed
      if (!isToday || !_isPastTimeForToday(timeString)) {
        timeSlots.add(timeString);
      }
      
      // Increment by 30 minutes
      currentMinute += 30;
      if (currentMinute >= 60) {
        currentMinute = 0;
        currentHour++;
      }
    }
  }

  // Helper method to add time slots from current time within working hours
  void _addTimeSlotsFromCurrentTime(int startHour, int startMinute, int endHour, int endMinute, List<String> timeSlots, DateTime now) {
    // Start from current time or working start time, whichever is later
    int currentHour = now.hour;
    int currentMinute = now.minute;
    
    // If current time is before the working start time, use working start time
    int workingStartInMinutes = startHour * 60 + startMinute;
    int currentInMinutes = currentHour * 60 + currentMinute;
    
    if (currentInMinutes < workingStartInMinutes) {
      currentHour = startHour;
      currentMinute = startMinute;
    } else {
      // Round up to the next 30-minute slot if needed
      if (currentMinute > 0 && currentMinute <= 30) {
        currentMinute = 30;
      } else if (currentMinute > 30) {
        currentMinute = 0;
        currentHour++;
      }
    }
    
    int endInMinutes = endHour * 60 + endMinute;
    
    while (currentHour < endHour || (currentHour == endHour && currentMinute < endMinute)) {
      int currentInMinutes = currentHour * 60 + currentMinute;
      
      if (currentInMinutes >= workingStartInMinutes && currentInMinutes < endInMinutes) {
        String timeString = _formatTime(currentHour, currentMinute);
        timeSlots.add(timeString);
      }
      
      // Increment by 30 minutes
      currentMinute += 30;
      if (currentMinute >= 60) {
        currentMinute = 0;
        currentHour++;
      }
    }
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