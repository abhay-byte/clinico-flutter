import 'package:flutter/material.dart';

class DateTimeSelectionScreen extends StatefulWidget {
  const DateTimeSelectionScreen({Key? key}) : super(key: key);

  @override
  _DateTimeSelectionScreenState createState() => _DateTimeSelectionScreenState();
}

class _DateTimeSelectionScreenState extends State<DateTimeSelectionScreen> {
  DateTime selectedDate = DateTime.now();
  String? selectedTime;
  DateTime currentMonth = DateTime.now();
  
  // Mock time slots - in a real app, these would come from an API
  final List<String> timeSlots = [
    '10:00 AM', '10:30 AM', '11:00 AM', '11:30 AM',
    '12:00 PM', '12:30 PM', '1:00 PM', '1:30 PM',
    '2:00 PM', '2:30 PM', '3:00 PM', '3:30 PM',
    '4:00 PM', '4:30 PM', '5:00 PM', '5:30 PM'
  ];

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
  Widget build(BuildContext context) {
    final List<DateTime> daysInMonth = _getDaysInMonth(currentMonth);
    final List<String> weekdays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

    return Scaffold(
      backgroundColor: const Color(0xFFF2F5F9), // Light cool-grey/blue tint
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Select Date And Time',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Color(0xFF1E3A8A), // Dark blue
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF2F5F9),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Month/Year Row and Navigation
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_getMonthName(currentMonth.month)} ${currentMonth.year}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: _previousMonth,
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: _nextMonth,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Weekdays Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: weekdays.map((day) =>
                Expanded(
                  child: Text(
                    day,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ).toList(),
            ),
            const SizedBox(height: 8),
            // Date Grid
            Expanded(
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
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                          ? const Color(0xFF3B82F6) // Blue for selected date
                          : isPast
                            ? Colors.transparent // Transparent for past dates
                            : Colors.transparent, // Transparent for other dates
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? const Color(0xFF3B82F6) : Colors.transparent,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(
                            color: isPast
                              ? Colors.grey // Grey for past dates
                              : !isCurrentMonth
                                ? Colors.grey // Grey for dates from other months
                                : isSelected
                                  ? Colors.white // White for selected date
                                  : isToday
                                    ? const Color(0xFF3B82F6) // Blue for today
                                    : Colors.black87, // Black for normal dates
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  );
                },
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
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 2.5,
                ),
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
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF3B82F6) : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? const Color(0xFF3B82F6) : Colors.grey.shade300,
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
                      child: Center(
                        child: Text(
                          time,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey.shade700,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: selectedTime != null ? () {
            // TODO: Navigate to confirmation screen with selected date and time
            print('Selected date: ${selectedDate.toString()}, time: $selectedTime');
          } : null, // Disable button if no time is selected
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3B82F6), // Solid blue background
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
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