import 'package:shared_preferences/shared_preferences.dart';

class sharedPreference {
  static Future<void> saveUserCredential(Map<String, dynamic> data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', data['email']);
    await prefs.setString('password', data['password']);
    await prefs.setString('username', data['username']);
    print("credential saved ! ");
  }

  static Future<void> saveUserCredentialGoogle(
      Map<String, dynamic> data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', data['accessToken']);
    await prefs.setString('idToken', data['idToken']);
    print("credential saved google !");
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

  static Future<bool> isUserGoogleExist() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = await prefs.getString('accessToken');
    final String? idToken = await prefs.getString('idToken');
    if (accessToken == null || idToken == null) {
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

  static Future<Map<String, dynamic>> getUserGoogleCredential() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? accessToken = await prefs.getString('accessToken');
    final String? idToken = await prefs.getString('idToken');
    return {
      'accessToken': accessToken,
      'idToken': idToken,
    };
  }

  static void removeUserCredential() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('password');
    await prefs.remove('username');
    await prefs.remove('idToken');
    await prefs.remove('accessToken');
    print("user credential deleted");
  }
}
