import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../core/server/shered_pref_helper.dart';

class MessageCountProvider with ChangeNotifier {
  int messageCount = 0;
  bool _disposed = false;

  MessageCountProvider() {
    _init();
  }

  void _init() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('Received a message while in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        int count = await SherdPrefHelper().getMessagesCount() ?? 0;
        await SherdPrefHelper().setMessagesCount(count + 1);
        messageCount = count + 1;
        if (!_disposed) notifyListeners();
      }
    });

    getMessagesCount();
    WidgetsBinding.instance.addObserver(LifecycleEventHandler(
      resumeCallBack: () async {
        await getMessagesCount();
      },
    ));
  }

  Future<void> getMessagesCount() async {
    messageCount = await SherdPrefHelper().getMessagesCount() ?? 0;
    if (!_disposed) notifyListeners();
  }

  Future<void> resetMessageCount() async {
    await SherdPrefHelper().setMessagesCount(0);
    messageCount = 0;
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    WidgetsBinding.instance.removeObserver(LifecycleEventHandler(
      resumeCallBack: () async {},
    ));
    super.dispose();
  }
}


class LifecycleEventHandler extends WidgetsBindingObserver {
  final Future<void> Function() resumeCallBack;

  LifecycleEventHandler({required this.resumeCallBack});

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      resumeCallBack();
    }
  }
}
