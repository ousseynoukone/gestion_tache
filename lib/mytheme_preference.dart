import 'package:shared_preferences/shared_preferences.dart';

class MyThemePreferences {
  //Cette constante est utilisée comme clé pour enregistrer et récupérer la
  //valeur du thème dans shared_preferences.
  static const THEME_KEY = "theme_key";

  //Elle est utilisée pour définir la valeur du thème
  setTheme(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(THEME_KEY, value);
  }

  //Elle st utilisée pour récupérer la valeur actuelle du thème à partir de shared_preferences
  getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(THEME_KEY) ?? false;
  }
}
