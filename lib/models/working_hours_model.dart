class WorkingHours {
  final String day;
  final String startTime;
  final String endTime;
  final bool isAvailable;

  WorkingHours({
    required this.day,
    required this.startTime,
    required this.endTime,
    this.isAvailable = true,
  });

  // Parse time string like "10:30am" to 24-hour format
  static int parseTimeToHours(String timeString) {
    // Convert time string like "10:30am" to hour in 24-hour format
    String time = timeString.toLowerCase().trim();
    bool isPM = time.contains('pm');
    bool isAM = time.contains('am');
    
    // Remove am/pm
    time = time.replaceFirst('am', '').replaceFirst('pm', '');
    
    List<String> parts = time.split(':');
    if (parts.length != 2) {
      throw ArgumentError('Invalid time format: $timeString');
    }
    
    int hour = int.tryParse(parts[0]) ?? 0;
    int minute = int.tryParse(parts[1]) ?? 0;
    
    // Convert to 24-hour format
    if (isPM && hour != 12) {
      hour += 12;
    } else if (isAM && hour == 12) {
      hour = 0;
    }
    
    return hour;
  }

 static int parseTimeToMinutes(String timeString) {
    String time = timeString.toLowerCase().trim();
    bool isPM = time.contains('pm');
    bool isAM = time.contains('am');
    
    // Remove am/pm
    time = time.replaceFirst('am', '').replaceFirst('pm', '');
    
    List<String> parts = time.split(':');
    if (parts.length != 2) {
      throw ArgumentError('Invalid time format: $timeString');
    }
    
    int hour = int.tryParse(parts[0]) ?? 0;
    int minute = int.tryParse(parts[1]) ?? 0;
    
    // Convert to 24-hour format
    if (isPM && hour != 12) {
      hour += 12;
    } else if (isAM && hour == 12) {
      hour = 0;
    }
    
    return hour * 60 + minute;
  }
}

class DoctorSchedule {
  final List<WorkingHours> workingHours;

  DoctorSchedule({required this.workingHours});

  // Get working hours for a specific day
  List<WorkingHours> getWorkingHoursForDay(String day) {
    return workingHours.where((hour) => hour.day.toLowerCase() == day.toLowerCase()).toList();
  }

  // Check if a specific time falls within any working hours for a day
  bool isTimeSlotAvailable(DateTime date, int hour, int minute) {
    String day = _getDayName(date);
    List<WorkingHours> dayHours = getWorkingHoursForDay(day);
    
    int requestedTimeInMinutes = hour * 60 + minute;
    
    for (WorkingHours hours in dayHours) {
      int startMinutes = WorkingHours.parseTimeToMinutes(hours.startTime);
      int endMinutes = WorkingHours.parseTimeToMinutes(hours.endTime);
      
      if (requestedTimeInMinutes >= startMinutes && requestedTimeInMinutes < endMinutes) {
        return true;
      }
    }
    
    return false;
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
}