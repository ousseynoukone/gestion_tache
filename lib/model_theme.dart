import 'package:flutter/material.dart';
import 'mytheme_preference.dart';

class ModelTheme extends ChangeNotifier {
  // Représente si l'application est en mode sombre ou non
  late bool _isDark;
  //Une instance de la classe MyThemePreferences, utilisée pour stocker et récupérer les préférences de thème.
  late MyThemePreferences _preferences;
  bool get isDark => _isDark;

  //ModelTheme initialise l'état du thème (_isDark) à false, crée une instance 
  //de la classe MyThemePreferences pour gérer les préférences du thème 
  //(_preferences), et appelle éventuellement une méthode getPreferences() 
  //pour récupérer la valeur du thème à partir des shared_preferences
  ModelTheme() {
    _isDark = false;
    _preferences = MyThemePreferences();
    getPreferences();
  }
//Switching the themes
  set isDark(bool value) {
    _isDark = value;
    _preferences.setTheme(value);
    notifyListeners();
  }

  getPreferences() async {
    _isDark = await _preferences.getTheme();
    notifyListeners();
  }
}

//notifyListeners() permet de mettre à jour dynamiquement le thème de l'application et de 
//répercuter les changements dans l'interface utilisateur.