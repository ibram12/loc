import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'local_state.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('en')) {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final localeCode = prefs.getString('locale') ?? 'en';
    emit(Locale(localeCode));
  }

  Future<void> switchLocale() async {
    final prefs = await SharedPreferences.getInstance();
    if (state.languageCode == 'en') {
      await prefs.setString('locale', 'ar');
      emit(const Locale('ar'));
    } else {
      await prefs.setString('locale', 'en');
      emit(const Locale('en'));
    }
  }
}
