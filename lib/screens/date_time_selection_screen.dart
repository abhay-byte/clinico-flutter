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
        '2:00 PM', '2:30 PM', '3:0 PM', '3:30 PM',
        '4:00 PM', '4:30 PM', '5:0 PM', '5:30 PM'
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

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB), // Updated background color
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button and centered title
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Changed to space between for back button and title
                children: [
                  // Back button without circle
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 20,
                      color: Color(0xFF333333), // Dark Grey for back icon
                    ),
                  ),
                  // Centered title
                  const Text(
                    'Select Date And Time',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Color(0xFF0F172A), // Dark Navy Blue
                    ),
                  ),
                  // Empty space to center the title
                  const SizedBox(width: 24), // Matching the width of the back button
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // Main content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Calendar Header with Month/Year and Navigation (without container)
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text(
                             _getMonthName(currentMonth.month),
                             style: const TextStyle(
                               fontSize: 18,
                               fontWeight: FontWeight.w500, // Medium font weight
                               color: Color(0xFF000000), // Black text for month
                             ),
                           ),
                           Text(
                             currentMonth.year.toString(),
                             style: const TextStyle(
                               fontSize: 18,
                               fontWeight: FontWeight.w700,
                               color: Color(0xFF2F80ED), // Blue text for year
                             ),
                           ),
                         ],
                       ),
                      const SizedBox(height: 16),
                      
                      // Weekdays Header - Changed to start with Monday
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: ['M', 'T', 'W', 'T', 'F', 'S', 'S'].map((day) =>
                          Expanded(
                            child: Text(
                              day,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700, // Bold text
                                color: Color(0xFF000000), // Black text
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ).toList(),
                      ),
                      const SizedBox(height: 8),
                      
                      // Date Grid - Removed container to float on main background
                      SizedBox(
                        height: 300, // Fixed height for the calendar grid
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
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
                                    ? const Color(0xFF2F80ED) // Solid Bright Blue for selected date
                                    : Colors.transparent,
                                  shape: BoxShape.circle, // Changed to circle for selected date
                                ),
                                child: Center(
                                  child: Text(
                                    date.day.toString(),
                                    style: TextStyle(
                                      color: isPast
                                        ? const Color(0xFFA0A0A0) // Darker grey for past dates
                                        : !isCurrentMonth
                                          ? const Color(0xFFA0A0A0) // Darker grey for dates from other months
                                          : isSelected
                                            ? Colors.white // White text for selected date
                                            : isToday
                                              ? const Color(0xFF2F80ED) // Blue for today
                                              : const Color(0xFF1A1A1A), // Darker black for other dates
                                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Available Time Slot section - Updated title
                      const Text(
                        'Available Time Slot', // Singular form
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Color(0xFF000000), // Black text
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Time Slot List
                      SizedBox(
                        height: 180,
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 3.5,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemCount: timeSlots.isEmpty ? 2 : timeSlots.length, // Show 2 default slots if empty
                          itemBuilder: (context, index) {
                            final String time;
                            final bool isSelected;
                            
                            if (timeSlots.isEmpty) {
                              // Use hardcoded default slots
                              if (index == 0) {
                                time = '10:00 AM';
                                isSelected = true; // Default selected
                              } else {
                                time = '4:30 PM';
                                isSelected = false;
                              }
                            } else {
                              time = timeSlots[index];
                              isSelected = selectedTime == time;
                            }
                            
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedTime = time;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isSelected
                                    ? const Color(0xFF2F80ED) // Solid Bright Blue for selected
                                    : Colors.white, // White for unselected
                                  borderRadius: BorderRadius.circular(20), // Pill shape
                                  boxShadow: isSelected
                                    ? null // No shadow for selected
                                    : [ // Enhanced shadow for unselected to make it pop
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2), // Increased opacity from 0.1 to 0.2
                                        spreadRadius: 1,
                                        blurRadius: 6, // Increased blur radius for more depth
                                        offset: const Offset(0, 3), // Increased offset for more depth
                                      ),
                                    ],
                                ),
                                child: Center(
                                  child: Text(
                                    time,
                                    style: TextStyle(
                                      color: isSelected
                                        ? Colors.white // White text for selected
                                        : const Color(0xFF828282), // Dark Grey text for unselected
                                      fontWeight: isSelected
                                        ? FontWeight.w700 // Bold for selected
                                        : FontWeight.w500, // Regular for unselected
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.only(bottom: 16),
        child: ElevatedButton(
          onPressed: () {
            // TODO: Navigate to confirmation screen with selected date and time
            print('Selected date: ${selectedDate.toString()}, time: $selectedTime');
            Navigator.of(context).pop({'date': selectedDate, 'time': selectedTime});
          }, // Always enabled
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2F80ED), // Solid Bright Blue theme color
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            shadowColor: const Color(0xFF2F80ED).withOpacity(0.3),
          ),
          child: const Text(
            'Set Appointment', // Changed text
            style: TextStyle(
              fontWeight: FontWeight.w700,
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