List<DateTime> getWeeklyRecurringDates(DateTime startDate, int weeks) {
  List<DateTime> dates = [];
  for (int i = 0; i < weeks; i++) {
    dates.add(startDate.add(Duration(days: 7 * i)));
  }
  return dates;
}


List<DateTime> getWeeklyRecurringWhenFiltiringData({
  required DateTime endDateCuruntMounth,
   required DateTime startDateCuruntMounth,
  required int weeks,
}) {
  List<DateTime> dates = [];
  DateTime now = DateTime.now();
  DateTime starttime = DateTime(now.year, now.month, startDateCuruntMounth.day,startDateCuruntMounth.hour, startDateCuruntMounth.minute);
  DateTime endtime = DateTime(now.year, now.month, endDateCuruntMounth.day,endDateCuruntMounth.hour, endDateCuruntMounth.minute);
  for (int i = 0; i < weeks; i++) {
    dates.add(starttime.add(Duration(days: 7 * i)));
    dates.add(endtime.add(Duration(days: 7 * i)));
    // dates.add(startDateOfTheScoundMounth.add(Duration(days: 7 * i)));
    // dates.add(endDateOfTheScoundMounth.add(Duration(days: 7 * i)));
  }
  return dates;
}