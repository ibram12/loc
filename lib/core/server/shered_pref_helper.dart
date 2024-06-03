import 'package:shared_preferences/shared_preferences.dart';

class SherdPrefHelper {
  static String name = 'userName';
  static String role = 'role';

  Future<bool> setUserName(String? getUserName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(name, getUserName ?? '');
  }

  Future<bool> setUserRole(bool isAdmin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(role, isAdmin);
  }

  Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(name);
  }

  Future<bool?> getUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(role);
  }
}
