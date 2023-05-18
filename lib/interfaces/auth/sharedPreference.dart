import 'package:shared_preferences/shared_preferences.dart';

class sharedPreference {
  static Future<void> saveUserCredential(Map<String, dynamic> data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', data['email']);
    await prefs.setString('password', data['password']);
    await prefs.setString('username', data['username']);
    print("credential saved ! ");
  }

  static Future<bool> isUserExist() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? email = await prefs.getString('email');
    final String? password = await prefs.getString('password');
    final String? username = await prefs.getString('username');
    if (email == null || password == null || username == null) {
      return false;
    }
    return true;
  }

  static Future<Map<String, dynamic>> getUserCredential() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? email = await prefs.getString('email');
    final String? password = await prefs.getString('password');
    final String? username = await prefs.getString('username');
    print(username);
    return {
      'email': email,
      'password': password,
      'username': username,
    };
  }

  static void removeUserCredential() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('password');
    await prefs.remove('username');
    print("user credential deleted");
  }
}
