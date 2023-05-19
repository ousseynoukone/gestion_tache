import 'package:flutter/material.dart';
import 'package:gestion_tache/interfaces/auth/password.dart';
import 'package:gestion_tache/interfaces/auth/register.dart';
import '../../globals/globals.dart' as globals;

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final GlobalKey<FormState> _formGlobalKey = GlobalKey<FormState>();

  String adr_email = "";
  final RegExp emailRegExp = RegExp(r"[a-z0-9\._-]+@[a-z0-9\._-]+\.[a-z]+");
  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'S\'authentifier',
          ),
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: const SizedBox(
                    height: 62,
                    child: Image(
                      image: AssetImage("resources/login.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Authentification'.toUpperCase(),
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                      //color: Theme.of(context).primaryColor,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                          //color: Theme.of(context).primaryColor,
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 70.0,
                ),
                Form(
                  key: _formGlobalKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Entrez votre adresse email',
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                            adr_email = value;
                            globals.username = value;
                          });
                        },
                        validator: (value) => adr_email.isEmpty ||
                                !emailRegExp.hasMatch(adr_email)
                            ? 'Vérifier l\'email saisi...'
                            : null,
                        decoration: InputDecoration(
                          hintText: 'ex:test@gmail.com',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.0),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        () {
                          if (globals.errorMessage != null) {
                            var errorMessage = globals.errorMessage!;
                            globals.errorMessage = null;
                            return errorMessage;
                          } else {
                            return "";
                          }
                        }(),
                        style: const TextStyle(
                            color: Color.fromARGB(255, 148, 0, 0)),
                      ),
                      Text(
                        () {
                          if (globals.successMessage != null) {
                            var successMessage = globals.successMessage!;
                            globals.successMessage = null;
                            return successMessage;
                          } else {
                            return "";
                          }
                        }(),
                        style: const TextStyle(
                            color: Color.fromARGB(255, 52, 114, 2)),
                      ),
                      Container(
                        constraints:
                            const BoxConstraints(minWidth: 350, minHeight: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: ElevatedButton(
                                onPressed: adr_email.isEmpty ||
                                        !emailRegExp.hasMatch(adr_email)
                                    ? null
                                    : () {
                                        if (_formGlobalKey.currentState!
                                            .validate()) {
                                          print('form validé');
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Password()));
                                        } else {
                                          print('form non validé');
                                        }
                                      },
                                style: ElevatedButton.styleFrom(
                                  elevation: 5.0,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                ),
                                child: Text(
                                  'Suivant'.toUpperCase(),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  print("pressed ! ");
                                  //     widget.onNext(3);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Register()));
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 5.0,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                ),
                                child: Text(
                                  'Créer un compte'.toUpperCase(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
