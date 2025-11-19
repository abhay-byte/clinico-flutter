import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants/colors.dart';

class DateTimeSelectionScreen extends StatefulWidget {
  final DateTime? preselectedDate;
  final String? preselectedTime;
  final Function(DateTime, String) onDateTimeSelected;

  const DateTimeSelectionScreen({
    Key? key,
    this.preselectedDate,
    this.preselectedTime,
    required this.onDateTimeSelected,
  }) : super(key: key);

  @override
  _DateTimeSelectionScreenState createState() => _DateTimeSelectionScreenState();
}

class _DateTimeSelectionScreenState extends State<DateTimeSelectionScreen> {
  late DateTime _selectedDate;
  String? _selectedTime;
  late DateTime _currentMonth;
  late List<String> _timeSlots;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.preselectedDate ?? DateTime.now();
    _selectedTime = widget.preselectedTime;
    _currentMonth = DateTime(_selectedDate.year, _selectedDate.month);
    _timeSlots = _generateTimeSlots();
  }

  List<String> _generateTimeSlots() {
    // Generate time slots for the selected date
    // For now, using a fixed set of time slots
    return [
      '9:00 AM',
      '10:00 AM',
      '1:00 AM',
      '1:00 PM',
      '2:00 PM',
      '3:00 PM',
      '4:00 PM',
      '4:30 PM',
      '5:00 PM',
      '6:00 PM',
    ];
  }

  void _changeMonth(int increment) {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + increment);
    });
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
    if (_selectedDate != null && _selectedTime != null) {
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
            // Calendar Header with Month Navigation
            _buildCalendarHeader(),
            const SizedBox(height: 16),
            // Day Headers
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

  Widget _buildCalendarHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => _changeMonth(-1),
        ),
        Text(
          '${DateFormat('MMM yyyy').format(_currentMonth)}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: () => _changeMonth(1),
        ),
      ],
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
    final daysInMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
    final firstDayOfWeek = DateTime(_currentMonth.year, _currentMonth.month, 1).weekday % 7;
    
    // Create a list of all days to display (including empty spaces for alignment)
    final days = <DateTime?>[];
    
    // Add empty spaces for days before the first day of the month
    for (int i = 0; i < firstDayOfWeek; i++) {
      days.add(null);
    }
    
    // Add all days of the month
    for (int day = 1; day <= daysInMonth; day++) {
      days.add(DateTime(_currentMonth.year, _currentMonth.month, day));
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
        if (day == null) {
          return Container(); // Empty space for alignment
        }

        final isToday = DateTime.now().day == day.day && 
                        DateTime.now().month == day.month && 
                        DateTime.now().year == day.year;
        final isSelected = _selectedDate.day == day.day && 
                           _selectedDate.month == day.month && 
                           _selectedDate.year == day.year;
        final isPast = day.isBefore(DateTime.now().subtract(const Duration(days: 1)));

        return GestureDetector(
          onTap: () {
            if (!isPast) {
              _selectDate(day);
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
                '${day.day}',
                style: TextStyle(
                  fontSize: 16,
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