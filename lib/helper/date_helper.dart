class DateHelper {
  static List<String> Months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  static List<String> Weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  static String getDayString(DateTime date) {
    return '${Weekdays[date.weekday - 1]}, ${date.day} ${Months[date.month - 1]}';
  }

  static String getTimeString(DateTime date) {
    String hr = date.hour.toString();
    String min = date.minute.toString();
    if (hr.length == 1) hr = '0$hr';
    if (min.length == 1) min = '0$min';
    return '$hr : $min';
  }
}
