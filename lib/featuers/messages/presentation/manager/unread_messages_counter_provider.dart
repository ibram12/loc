import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageCountProvider with ChangeNotifier {
  int messageCount = 0;
  bool _dispose = false;

  @override
  void dispose() {
    _dispose = true;
    super.dispose();
  }

  Future<void> getMessagesCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    messageCount = prefs.getInt('messagesCount') ?? 0;
    if(!_dispose){
      notifyListeners();
    print("message count $messageCount");
    }
    
  }

  Future<void> resetMessageCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('messagesCount', 0);
        if(!_dispose){
          
    messageCount = 0;
    notifyListeners();
        }

  }

  static final List<VoidCallback> _listeners = [];

  static void addlistener(VoidCallback listener) {
    _listeners.add(listener);
  }

  static void notifyAllListeners() {
    for (var listener in _listeners) {
      listener();
    }
  }
}
