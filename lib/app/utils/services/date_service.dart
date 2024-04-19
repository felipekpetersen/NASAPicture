import 'package:intl/intl.dart';

class DateService {
  DateService._();

  static final f = DateFormat('yyyy-MM-dd');

  static String get today => f.format(DateTime.now());
  
  static String tenDaysAgo(String fromDate) {
    return f.format(DateTime.parse(fromDate).subtract(const Duration(days: 10)));
  }

  static bool isLaterThanToday(String fromDate) {
    return DateTime.parse(fromDate).day > DateTime.now().day;
  }
}
