import 'package:shared_preferences/shared_preferences.dart';

class SherdPrefHelper {
  static String name = 'userName';
  static String role = 'role';
    static String userImage = 'userImage';  


  Future<bool> setUserName(String? getUserName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(name, getUserName ?? '');
  }

  Future<bool> setUserRole(bool isAdmin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(role, isAdmin);
  }

    Future<bool> setUserImage(String? imageUrl) async {  
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userImage, imageUrl ?? '');
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
