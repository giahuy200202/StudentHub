import 'package:intl/intl.dart';

class DateTimeHelper {
  DateTimeHelper();

  bool isSameDate(DateTime date_1, DateTime date_2) {
    return date_1.year == date_2.year &&
        date_1.month == date_2.month &&
        date_1.day == date_2.day;
  }

  String getDateFormatted(DateTime date, DateTime today, bool isCompleted) {
    if (isSameDate(date, today) && !isCompleted) {
      return 'Today - ${DateFormat("dd/MM/yyyy | HH:mm").format(date).toString()}';
    } else if (date.compareTo(today) > 0 && !isCompleted) {
      return 'Upcoming - ${DateFormat("dd/MM/yyyy | HH:mm").format(date).toString()}';
    } else if (date.compareTo(today) < 0 && !isCompleted) {
      return 'Overdue - ${DateFormat("dd/MM/yyyy | HH:mm").format(date).toString()}';
    }
    return 'Completed';
  }
}
