import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../featuers/messages/presentation/manager/unread_messages_counter_provider.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  int messageCount = prefs.getInt('messagesCount') ?? 0;
  messageCount++;
  await prefs.setInt('messagesCount', messageCount);
  print('New message count: $messageCount');
  MessageCountProvider.notifyAllListeners();

}
