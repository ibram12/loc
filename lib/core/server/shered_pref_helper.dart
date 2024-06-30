import 'package:shared_preferences/shared_preferences.dart';

class SherdPrefHelper {
  static String name = 'userName';
  static String role = 'role';
  static String userImage = 'userImage';
  static String lastDeletionDateKey = 'lastDeletionDateKey';
  static String messageCount = "messagesCount";

  Future<bool> setUserName(String? getUserName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(name, getUserName ?? '');
  }

    Future<void> setMessagesCount(int count) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(messageCount, count);
  
}
  Future<bool> setUserRole(String isAdmin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(role, isAdmin);
  }

  Future<bool> setDeletionDate(String? now) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(
        lastDeletionDateKey, now ?? DateTime(1970).toString());
  }

  Future<bool> setUserImage(String? imageUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userImage, imageUrl ?? '');
  }

  Future<String?> getLastDeletionDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(lastDeletionDateKey);
  }

  Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(name);
  }

  Future<String?> getUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(role);
  }

  Future<String?> getUserImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userImage);
  }

  Future<int?> getMessagesCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(messageCount);
  }
}
