import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'log_out_state.dart';

class LogOutCubit extends Cubit<LogOutState> {
  LogOutCubit() : super(LogOutInitial());

  Future<void> logOut() async {
    emit(LogOutLoading());
    await FirebaseAuth.instance.signOut();

    var prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    emit(LogOutSuccess());
  }
}
