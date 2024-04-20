import 'package:intl/intl.dart';

class DateService {
  DateService._();

  static final f = DateFormat('yyyy-MM-dd');

  static String get today => f.format(DateTime.now());
  
  static String getDaysAgo(String fromDate, int numberOfDays) {
    return f.format(DateTime.parse(fromDate).subtract(Duration(days: numberOfDays)));
  }

  static String getDayBefore(String fromDate) {
    return f.format(DateTime.parse(fromDate).subtract(const Duration(days: 1)));
  }

  static String getDayAfter(String fromDate) {
    return f.format(DateTime.parse(fromDate).add(const Duration(days: 1)));
  }

  static bool isLaterThanToday(String fromDate) {
    return DateTime.parse(fromDate).day > DateTime.now().day;
  }
}
