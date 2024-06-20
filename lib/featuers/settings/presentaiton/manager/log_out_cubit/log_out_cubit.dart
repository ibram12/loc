import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/utils/constants.dart';
import '../../../../messages/data/models/chat_buble_model.dart';

part 'log_out_state.dart';

class LogOutCubit extends Cubit<LogOutState> {
  LogOutCubit() : super(LogOutInitial());

  Future<void> logOut() async {
    emit(LogOutLoading());
    await FirebaseAuth.instance.signOut();
    await Hive.box<ChatBubleModel>(kMessagesBox).clear();

    var prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    emit(LogOutSuccess());
  }
}
