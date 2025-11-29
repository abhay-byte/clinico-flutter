import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants/colors.dart';

class DateTimeSelectionScreen extends StatefulWidget {
  final DateTime? preselectedDate;
  final String? preselectedTime;
  final Function(DateTime, String) onDateTimeSelected;

  const DateTimeSelectionScreen({
    super.key,
    this.preselectedDate,
    this.preselectedTime,
    required this.onDateTimeSelected,
  });

  @override
  _DateTimeSelectionScreenState createState() => _DateTimeSelectionScreenState();
}

class _DateTimeSelectionScreenState extends State<DateTimeSelectionScreen> {
  late DateTime _selectedDate;
  String? _selectedTime;
  late List<String> _timeSlots;
  
  // Configurable working hours
  static const int WORKING_HOURS_START = 10; // 10:00 AM
  static const int WORKING_HOURS_END = 17;   // 5:00 PM (17:00)

  @override
    void initState() {
      super.initState();
      _selectedDate = widget.preselectedDate ?? DateTime.now();
      _selectedTime = widget.preselectedTime;
      _timeSlots = _generateTimeSlots();
    }

  List<String> _generateTimeSlots() {
      List<String> slots = [];
      
      // Determine if we're generating slots for today (need to filter past times)
          bool isToday = DateTime.now().day == _selectedDate.day &&
                         DateTime.now().month == _selectedDate.month &&
                         DateTime.now().year == _selectedDate.year;
          
          int startHour = WORKING_HOURS_START;
          int endHour = WORKING_HOURS_END;
    
    // If it's today, adjust the start time to current time
    DateTime now = DateTime.now();
    if (isToday) {
      startHour = now.hour;
      
      // If we're past the end hour, return empty slots
      if (startHour > endHour) {
        return [];
      }
      
      // If current hour matches start hour, check minutes to see if we need to start later
      if (startHour == now.hour) {
        int currentMinute = now.minute;
        // If current time is past 30 min, start from next 30-min slot
        if (currentMinute > 30) {
          startHour = now.hour + 1;
        } else if (currentMinute > 0) {
          // If current time is past the hour but before 30 min, add 30 min slot
          String timeString = _formatTime(now.hour, 30);
          if (!_isPastTimeForToday(timeString)) {
            slots.add(timeString);
          }
        }
      }
    }
    
    // Generate time slots in 30-minute intervals
    for (int hour = startHour; hour <= endHour; hour++) {
      // Add the :00 slot
      if (hour == endHour) {
        // At the end hour, only add the :00 slot if it's not past
        String timeString = _formatTime(hour, 0);
        if (!_isPastTimeForToday(timeString)) {
          slots.add(timeString);
        }
      } else {
        String timeString = _formatTime(hour, 0);
        if (!_isPastTimeForToday(timeString)) {
          slots.add(timeString);
        }
        
        // Add the :30 slot
        timeString = _formatTime(hour, 30);
        if (!_isPastTimeForToday(timeString)) {
          slots.add(timeString);
        }
      }
    }
    
    return slots;
  }

  // Check if a time slot is in the past when today is selected
  bool _isPastTimeForToday(String timeString) {
    bool isToday = DateTime.now().day == _selectedDate.day &&
                   DateTime.now().month == _selectedDate.month &&
                   DateTime.now().year == _selectedDate.year;
    
    if (!isToday) return false;
    
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

  void _selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
      _selectedTime = null; // Reset time selection when date changes
    });
  }

  void _selectTime(String time) {
    setState(() {
      _selectedTime = time;
    });
  }

  void _setAppointment() {
    if (_selectedTime != null) {
      widget.onDateTimeSelected(_selectedDate, _selectedTime!);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset('assets/book_appointment/back.png', width: 24, height: 24),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Select Date And Time',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                        // Day Headers - showing only the day of week abbreviations
                        _buildDayHeaders(),
                        const SizedBox(height: 8),
            // Calendar Grid
            _buildCalendarGrid(),
            const SizedBox(height: 24),
            // Available Time Slots
            const Text(
              'Available Time Slot',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            _buildTimeSlotChips(),
            const Spacer(),
            // Set Appointment Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _selectedTime != null ? _setAppointment : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedTime != null 
                      ? AppColors.b4
                      : AppColors.b4.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Set Appointment',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
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

  Widget _buildDayHeaders() {
      final days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
      return Row(
        children: days.map((day) {
          return Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                day,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }).toList(),
      );
    }

  Widget _buildCalendarGrid() {
      // Generate the next 14 days starting from today
      List<DateTime> days = [];
      DateTime today = DateTime.now();
      
      for (int i = 0; i < 14; i++) {
        days.add(DateTime(today.year, today.month, today.day + i));
      }
  
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          childAspectRatio: 1.0,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemCount: days.length,
        itemBuilder: (context, index) {
          final day = days[index];
  
          final isToday = DateTime.now().day == day.day &&
                          DateTime.now().month == day.month &&
                          DateTime.now().year == day.year;
          final isTomorrow = DateTime.now().add(const Duration(days: 1)).day == day.day &&
                             DateTime.now().add(const Duration(days: 1)).month == day.month &&
                             DateTime.now().add(const Duration(days: 1)).year == day.year;
          final isSelected = _selectedDate.day == day.day &&
                             _selectedDate.month == day.month &&
                             _selectedDate.year == day.year;
          final isPast = day.isBefore(DateTime.now().subtract(const Duration(days: 1)));
  
          // Format the date label
          String dateLabel;
          if (isToday) {
            dateLabel = 'Today';
          } else if (isTomorrow) {
            dateLabel = 'Tomorrow';
          } else {
            // Format as DD MMM (e.g., 20th Nov)
            String dayString = day.day.toString();
            String dayWithSuffix = _getDayWithSuffix(day.day);
            String monthString = DateFormat('MMM').format(day);
            dateLabel = '$dayWithSuffix $monthString';
          }
  
          return GestureDetector(
            onTap: () {
              if (!isPast) {
                _selectDate(day);
                // Regenerate time slots for the selected date
                setState(() {
                  _timeSlots = _generateTimeSlots();
                  _selectedTime = null; // Reset time selection when date changes
                });
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.b4
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  dateLabel,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected
                        ? Colors.white
                        : isPast
                            ? Colors.grey
                            : Colors.black,
                  ),
                ),
              ),
            ),
          );
        },
      );
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

  Widget _buildTimeSlotChips() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _timeSlots.map((time) {
        final isSelected = _selectedTime == time;
        return ChoiceChip(
          label: Text(
            time,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          selected: isSelected,
          selectedColor: AppColors.b4,
          backgroundColor: Colors.grey.shade200,
          onSelected: (selected) {
            if (selected) {
              _selectTime(time);
            }
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: isSelected ? AppColors.b4 : Colors.grey.shade300,
            ),
          ),
        );
      }).toList(),
    );
  }
}