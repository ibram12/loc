import 'package:shared_preferences/shared_preferences.dart';

class SherdPrefHelper {
  static String name = 'userName';
  static String role = 'role';
    static String userImage = 'userImage';  
    static String lastDeletionDateKey = 'lastDeletionDateKey';


  Future<bool> setUserName(String? getUserName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(name, getUserName ?? '');
  }

  Future<bool> setUserRole(bool isAdmin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(role, isAdmin);
  }
    Future<bool> setDeletionDate(String? now)async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
return prefs.setString(lastDeletionDateKey, now??DateTime(1970).toString());
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

  Future<bool?> getUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(role);
  }

    Future<String?> getUserImage() async {  
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userImage);
  }
}
