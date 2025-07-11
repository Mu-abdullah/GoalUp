import 'package:intl/intl.dart';

class TimeRefactor {
  final String timestamp;

  TimeRefactor(this.timestamp);

  // Convert timestamp to date format: yyyy/MM/dd
  String toDateString({String format = 'yyyy-MM-dd', String lang = 'en'}) {
    try {
      final dateTime = DateTime.parse(timestamp);
      return DateFormat(format, lang).format(dateTime);
    } catch (e) {
      return 'Invalid timestamp';
    }
  }

  // Convert timestamp to time format: HH:mm
  String toTimeString() {
    try {
      final dateTime = DateTime.parse(timestamp);
      return DateFormat('hh:mm a').format(dateTime);
    } catch (e) {
      return 'Invalid timestamp';
    }
  }

  String timeString({String lang = 'en'}) {
    try {
      final dateTime = DateTime.parse(timestamp);
      return DateFormat('hh:mm a\nyyyy-MM-dd', lang).format(dateTime);
    } catch (e) {
      return 'Invalid timestamp';
    }
  }

  static String currentDateString({String format = 'yyyy-MM-dd'}) {
    final now = DateTime.now();
    return DateFormat(format).format(now);
  }

  Duration calculateDuration(String? endTime) {
    final start = _parseTime(timestamp);
    final end = _parseTime(endTime ?? DateTime.now().toIso8601String());
    return end.difference(start);
  }

  DateTime _parseTime(String time) {
    return DateTime.parse(time);
  }

  static int calculateAge(String birthday) {
    final birthDate = DateTime.parse(birthday);
    final today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  static (int years, int months) calculatePeriod(String from, String to) {
    final start = DateTime.parse(from);
    final end = DateTime.parse(to);

    int years = end.year - start.year;
    int months = end.month - start.month;

    // لو اليوم في "end" أصغر من "start"، نخصم شهر
    if (end.day < start.day) {
      months -= 1;
    }

    // لو عدد الشهور بالسالب، نخصم سنة ونعدّل الشهور
    if (months < 0) {
      years -= 1;
      months += 12;
    }

    return (years, months);
  }
}
