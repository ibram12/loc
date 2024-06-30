import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  WidgetsFlutterBinding.ensureInitialized();

  print('Handling a background message: ${message.messageId}');

  SharedPreferences prefs = await SharedPreferences.getInstance();
  int messageCount = prefs.getInt('messagesCount') ?? 0;
  messageCount++;
  await prefs.setInt('messagesCount', messageCount);
  print('New message count: $messageCount');
}
