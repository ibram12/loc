import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('themeMode') ?? false;
    emit(isDarkMode ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> switchTheme() async {
    final prefs = await SharedPreferences.getInstance();
    if (state == ThemeMode.light) {
      await prefs.setBool('themeMode', true);
      emit(ThemeMode.dark);
    } else {
      await prefs.setBool('themeMode', false);
      emit(ThemeMode.light);
    }
  }
}