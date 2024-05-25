import 'package:shared_preferences/shared_preferences.dart';

class SherdPrefHelper {
  static String name = 'userName';
  static String lastDeletionDateKey = 'lastDeletionDate';



  Future<bool> setUserName(String? getUserName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(name, getUserName??'');
  }

  Future<bool> setDeletionDate(String? now)async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
return prefs.setString(lastDeletionDateKey, now??DateTime(1970).toString());
  }

  
  Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(name);
  }

  Future<String?> getLastDeletionDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(lastDeletionDateKey);
  }
}
