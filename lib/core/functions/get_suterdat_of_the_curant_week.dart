  DateTime getSuterDayOfCurrentWeek(DateTime date) {
    int daysSinceSuterDay = (date.weekday + 1) % 7;
    DateTime suterDay = date.subtract(Duration(days: daysSinceSuterDay));
    return DateTime(suterDay.year, suterDay.month, suterDay.day);
  }