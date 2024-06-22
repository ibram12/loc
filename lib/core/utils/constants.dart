import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

const String kFontFamily = 'Poppins';
const Color kPrimaryColor = Colors.deepOrange;
const Color kOrange = Colors.orange;
const String kLogo = 'assets/images/app_logo.jpg';
const  List<String> kServices = [
  'ملائكه',
    'خدمه ابتدائي بنين',
    'خدمه ابتدائي بنات',
    'خدمه اعدادي بنين',
    'خدمه اعدادي بنات',
    'خدمه ثانوي بنين',
    'خدمه ثانوي بنات',
    'جامعين',
    'رجاله',
    'حديثي الزواج',
    'كشافه',
  ];

const Map<String, Color> kServiceColors = {
  'ملائكه': Colors.red,
  'خدمه ابتدائي بنين': Colors.blue,
  'خدمه ابتدائي بنات': Colors.green,
  'خدمه اعدادي بنين': Colors.yellow,
  'خدمه اعدادي بنات': Colors.orange,
  'خدمه ثانوي بنين': Colors.purple,
  'خدمه ثانوي بنات': Colors.pink,
  'جامعين': Colors.brown,
  'رجاله': Colors.teal,
  'حديثي الزواج': Colors.cyan,
  'كشافه': Colors.lime,
};

const   List<String> kRoles = ['User','Moderator','Admin'];
const List<CalendarView> kCalendarViews = [CalendarView.day, CalendarView.workWeek,CalendarView.month];

const String kMessagesBox = 'ramy';

const String kTopic = 'topic';

