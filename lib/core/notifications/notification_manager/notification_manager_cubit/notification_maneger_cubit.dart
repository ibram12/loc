import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:loc/featuers/home/presentaiton/views/homePage.dart';
import 'package:loc/featuers/requests/presentatoin/views/requests_view.dart';
import 'package:meta/meta.dart';

import '../../../../featuers/messages/presentation/views/messages_veiw.dart';

part 'notification_maneger_state.dart';

class NotificationManegerCubit extends Cubit<NotificationManegerState> {
  NotificationManegerCubit() : super(NotificationManegerInitial());

  void onNotificationTapped(BuildContext context) {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
     if (message != null) {
        _navigateToTargetScreen(message, context);
      }
    });
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        _navigateToTargetScreen(message, context);
      }
    });
  }

  void _navigateToTargetScreen(RemoteMessage message, BuildContext context) {
    final String ? screen = message.data['screen'];
    if (screen != null) {
      if (screen == MessagesVeiw.id) {
        Navigator.pushNamed(context, MessagesVeiw.id);
      } else if (screen == UserRequests.id) {
        Navigator.pushNamed(context, UserRequests.id);
      }  else {
        Navigator.pushNamed(context, MyHomePage.id);
      }
    } else {
      Navigator.pushNamed(context, MyHomePage.id);
    }
  }
}
