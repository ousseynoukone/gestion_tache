import 'package:flutter/material.dart';
import 'package:Groupe_8/interfaces/auth/sharedPreference.dart';
import 'package:Groupe_8/interfaces/auth/authEmailPasswordCheck.dart';
import 'package:Groupe_8/globals/globals.dart' as globals;
import '../Default/accueil.dart';
import 'auth.dart';
import 'package:Groupe_8/model_theme.dart';
import 'package:provider/provider.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  bool _isLogIn = true;

  void initState() {
    loadAuthCredential();
    _isLogIn = true;
  }


  // void loadAuthCredential() async {
  //   Map<String, dynamic> credential = await rememberMe.readAuthCredential();
  //   if (credential.isEmpty == false) {
  //     var rep = await AuthCheckAndCreate.userLogIn(
  //         credential['email'], credential['password']);
  //     if (rep == null) {
  //       setState(() {
  //         _isLogIn = false;
  //       });
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => const Accueil()));
  //     } else {}
  //   } else {
  //     setState(() {
  //       _isLogIn = false;
  //     });
  //   }
  // }
  void loadAuthCredential() async {
    Map<String, dynamic> credential =
        await sharedPreference.getUserCredential();
    Map<String, dynamic> credentialGoogle =
        await sharedPreference.getUserGoogleCredential();
    if (credential.isNotEmpty &&
        credential['email'] != null &&
        credential['password'] != null) {
      var rep = await AuthCheckAndCreate.userLogIn(
          credential['email'], credential['password']);
      if (rep == null) {
        setState(() {
          _isLogIn = false;
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Accueil()));
      } else {}
    } else if (credentialGoogle.isNotEmpty &&
        credentialGoogle['accessToken'] != null &&
        credentialGoogle['idToken'] != null) {

      var rep = await AuthCheckAndCreate.userGoogleLogIn (
          credentialGoogle['accessToken'], credentialGoogle['idToken']);

      if (rep == null) {
        setState(() {
          _isLogIn = false;
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Accueil()));
      }
    } else {
      setState(() {
        _isLogIn = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
        return Scaffold(
          appBar: AppBar(
              title: Text(themeNotifier.isDark ? "Dark Mode" : "Light Mode"),
              actions: [
                IconButton(
                    icon: Icon(themeNotifier.isDark
                        ? Icons.nightlight_round
                        : Icons.wb_sunny),
                    onPressed: () {
                      themeNotifier.isDark
                          ? themeNotifier.isDark = false
                          : themeNotifier.isDark = true;
                    })
              ]),
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: const SizedBox(
                      height: 400,
                      child: Image(
                        image: AssetImage("resources/start.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "Bienvenue dans votre application de gestion des tâches",
                  style: TextStyle(
                      color: themeNotifier.isDark ? Colors.white : Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 19),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 65.0,
              ),
              ElevatedButton(
                  onPressed: _isLogIn
                      ? null
                      : () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Auth()));
                        },
                  style: ElevatedButton.styleFrom(
                    elevation: 5.0,
                    backgroundColor: themeNotifier.isDark ? Color.fromARGB(255, 35, 11, 77) : Theme.of(context).primaryColor,//Theme.of(context).primaryColor,
                    foregroundColor: Theme.of(context).secondaryHeaderColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    minimumSize: const Size(200, 50),
                  ),
                  child: _isLogIn
                      ? CircularProgressIndicator()
                      : Text(
                          ' Allons-y ! '.toUpperCase(),
                          style: const TextStyle(fontSize: 15),
                        )),
            ],
          ));
    });
  }
}
