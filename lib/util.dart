String weekdayToString(int weekday) {
  switch (weekday) {
    case DateTime.monday:
      return "Monday";
    case DateTime.tuesday:
      return "Tuesday";
    case DateTime.wednesday:
      return "Wednesday";
    case DateTime.thursday:
      return "Thursday";
    case DateTime.friday:
      return "Friday";
    case DateTime.saturday:
      return "Saturday";
    case DateTime.sunday:
      return "Sunday";
    default:
      return "Unknown";
  }
}

String monthToString(int month) {
  switch (month) {
    case DateTime.january:
      return "January";
    case DateTime.february:
      return "February";
    case DateTime.march:
      return "March";
    case DateTime.april:
      return "April";
    case DateTime.may:
      return "May";
    case DateTime.june:
      return "June";
    case DateTime.july:
      return "July";
    case DateTime.august:
      return "August";
    case DateTime.september:
      return "September";
    case DateTime.october:
      return "October";
    case DateTime.november:
      return "November";
    case DateTime.december:
      return "December";
    default:
      return "Unknown";
  }
}

String prettifyDate(DateTime dateTime) {
  return '${weekdayToString(dateTime.weekday).substring(0, 3)}, ${monthToString(dateTime.month)} ${dateTime.day}, ${dateTime.year}';
}
