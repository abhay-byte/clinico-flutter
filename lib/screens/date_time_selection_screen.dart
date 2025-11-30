import 'package:flutter/material.dart';
import '../models/working_hours_model.dart';

class DateTimeSelectionScreen extends StatefulWidget {
  final List<WorkingHours> workingHours;
  
  const DateTimeSelectionScreen({Key? key, this.workingHours = const []}) : super(key: key);

  @override
  _DateTimeSelectionScreenState createState() => _DateTimeSelectionScreenState();
}

class _DateTimeSelectionScreenState extends State<DateTimeSelectionScreen> {
  DateTime selectedDate = DateTime.now();
  String? selectedTime;
  DateTime currentMonth = DateTime.now();
  
  List<String> timeSlots = [];

  // Get the list of days for the current month view
  List<DateTime> _getDaysInMonth(DateTime month) {
    final DateTime firstDay = DateTime(month.year, month.month, 1);
    final DateTime lastDay = DateTime(month.year, month.month + 1, 0);
    final int firstDayWeekday = firstDay.weekday;
    
    // Add days from previous month to fill the first week
    final List<DateTime> days = <DateTime>[];
    for (int i = firstDayWeekday - 1; i > 0; i--) {
      days.add(DateTime(firstDay.year, firstDay.month - 1, firstDay.day - i));
    }
    
    // Add all days of the current month
    for (int i = 1; i <= lastDay.day; i++) {
      days.add(DateTime(month.year, month.month, i));
    }
    
    // Add days from next month to fill the last week
    final int totalDays = days.length;
    final int remainingDays = 42 - totalDays; // 6 weeks x 7 days
    for (int i = 1; i <= remainingDays; i++) {
      days.add(DateTime(lastDay.year, lastDay.month + 1, i));
    }
    
    return days;
  }

  // Check if two dates are the same day
  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.day == date2.day &&
        date1.month == date2.month &&
        date1.year == date2.year;
  }

 // Check if a date is in the past
  bool _isPastDate(DateTime date) {
    final DateTime today = DateTime.now();
    return date.isBefore(DateTime(today.year, today.month, today.day));
  }

  // Navigate to the previous month
  void _previousMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month - 1, currentMonth.day);
    });
  }

  // Navigate to the next month
  void _nextMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month + 1, currentMonth.day);
    });
  }

  @override
 void initState() {
    super.initState();
    _generateTimeSlots();
  }

  // Generate time slots based on selected date and working hours
  void _generateTimeSlots() {
    if (widget.workingHours.isEmpty) {
      // Fallback to default time slots if no working hours provided
      timeSlots = [
        '10:00 AM', '10:30 AM', '11:00 AM', '11:30 AM',
        '12:00 PM', '12:30 PM', '1:00 PM', '1:30 PM',
        '2:00 PM', '2:30 PM', '3:00 PM', '3:30 PM',
        '4:00 PM', '4:30 PM', '5:00 PM', '5:30 PM'
      ];
      return;
    }

    List<String> newTimeSlots = [];
    
    // Determine the date for which we're generating slots
    DateTime targetDate = selectedDate;
    
    // Get working hours for the selected date
    List<WorkingHours> dayWorkingHours = _getWorkingHoursForDate(targetDate);
    
    for (WorkingHours hours in dayWorkingHours) {
      int startHour = WorkingHours.parseTimeToHours(hours.startTime);
      int startMinute = int.tryParse(hours.startTime.split(':')[1].replaceAll(RegExp(r'[aApPmM]'), '')) ?? 0;
      int endHour = WorkingHours.parseTimeToHours(hours.endTime);
      int endMinute = int.tryParse(hours.endTime.split(':')[1].replaceAll(RegExp(r'[aApPmM]'), '')) ?? 0;
      
      // Check if today is selected to filter out past time slots
      bool isToday = _isSameDay(selectedDate, DateTime.now());
      DateTime now = DateTime.now();
      
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
    DateTime now = DateTime.now();
    List<String> timeParts = timeString.split(' ');
    if (timeParts.length != 2) return false;
    
    String time = timeParts[0];
    String period = timeParts[1];
    
    List<String> hourMinute = time.split(':');
    if (hourMinute.length != 2) return false;
    
    int hour = int.tryParse(hourMinute[0]) ?? 0;
    int minute = int.tryParse(hourMinute[1].replaceAll(' AM', '').replaceAll(' PM', '')) ?? 0;
    
    // Convert to 24-hour format for comparison
    if (period.toUpperCase() == 'PM' && hour != 12) {
      hour += 12;
    } else if (period.toUpperCase() == 'AM' && hour == 12) {
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

  @override
  Widget build(BuildContext context) {
    final List<DateTime> daysInMonth = _getDaysInMonth(currentMonth);
    final List<String> weekdays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

    return Scaffold(
      backgroundColor: const Color(0xFFEBF1FA), // bg1 from color palette
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18, color: Color(0xFF174B80)), // b1 from color palette
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Select Date And Time',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Color(0xFF174B80), // b1 from color palette
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFEBF1FA), // bg1 from color palette
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Calendar Header with Month/Year and Navigation
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_getMonthName(currentMonth.month)} ${currentMonth.year}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF174B80), // b1 from color palette
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left, color: Color(0xFF174B80)), // b1 from color palette
                        onPressed: _previousMonth,
                      ),
                      IconButton(
                        icon: const Icon(Icons.chevron_right, color: Color(0xFF174B80)), // b1 from color palette
                        onPressed: _nextMonth,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Weekdays Header
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: weekdays.map((day) =>
                  Expanded(
                    child: Text(
                      day,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF717171), // ge2 from color palette
                        fontSize: 14,
                      ),
                    ),
                  ),
                ).toList(),
              ),
            ),
            const SizedBox(height: 8),
            // Date Grid
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(), // Disable scrolling for grid
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    childAspectRatio: 1.0,
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                  ),
                  itemCount: daysInMonth.length,
                  itemBuilder: (context, index) {
                    final DateTime date = daysInMonth[index];
                    final bool isCurrentMonth = date.month == currentMonth.month;
                    final bool isToday = _isSameDay(date, DateTime.now());
                    final bool isSelected = _isSameDay(date, selectedDate);
                    final bool isPast = _isPastDate(date) && !isToday;

                    return GestureDetector(
                      onTap: () {
                        if (!isPast) {
                          setState(() {
                            selectedDate = date;
                            selectedTime = null; // Reset selected time when date changes
                          });
                          _generateTimeSlots(); // Regenerate time slots when date changes
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                            ? const Color(0xFF174B80) // b1 from color palette
                            : isPast
                              ? Colors.transparent // Transparent for past dates
                              : Colors.transparent, // Transparent for other dates
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected ? const Color(0xFF174B80) : Colors.transparent,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            date.day.toString(),
                            style: TextStyle(
                              color: isPast
                                ? const Color(0xFFE5E5E5) // ge3 from color palette
                                : !isCurrentMonth
                                  ? const Color(0xFFE5E5) // ge3 from color palette
                                  : isSelected
                                    ? Colors.white // White for selected date
                                    : isToday
                                      ? const Color(0xFF174B80) // b1 from color palette
                                      : const Color(0xFF1F1F1F), // ge1 from color palette
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Available Time Slot section
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Available Time Slot',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF174B80), // b1 from color palette
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Time Slot List - Changed from Expanded to Flexible to fix layout
            Flexible(
              child: Container(
                height: 200, // Fixed height for time slot list
                child: ListView.builder(
                  itemCount: timeSlots.length,
                  itemBuilder: (context, index) {
                    final time = timeSlots[index];
                    final isSelected = selectedTime == time;
                    
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTime = time;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF174B80) : Colors.white, // b1 from color palette
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: isSelected ? const Color(0xFF174B80) : const Color(0xFFE5E5E5), // b1 or ge3 from color palette
                          ),
                          boxShadow: !isSelected
                              ? [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : null,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              time,
                              style: TextStyle(
                                color: isSelected ? Colors.white : const Color(0xFF1F1F1F), // ge1 from color palette
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                fontSize: 14,
                              ),
                            ),
                            if (isSelected)
                              Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 20,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: selectedTime != null ? () {
            // TODO: Navigate to confirmation screen with selected date and time
            print('Selected date: ${selectedDate.toString()}, time: $selectedTime');
            Navigator.of(context).pop({'date': selectedDate, 'time': selectedTime});
          } : null, // Disable button if no time is selected
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF174B80), // b1 from color palette
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Set Appointment',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
  
  // Helper function to get month name
  String _getMonthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }
}