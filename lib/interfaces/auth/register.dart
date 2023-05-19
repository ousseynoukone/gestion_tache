import 'package:flutter/material.dart';
import 'package:gestion_tache/interfaces/auth/auth.dart';
import '../../globals/globals.dart' as globals;

import 'authEmailPasswordCheck.dart' as authObject;

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formGlobalKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String name = "";
  bool _isAuthenticating = false;
  bool _obscureText = true;


  final RegExp emailRegExp = RegExp(r"[a-z0-9\._-]+@[a-z0-9\._-]+\.[a-z]+");
  bool isValidText(String text) {
    // Vérifie si la chaîne contient au moins une lettre
    bool hasLetter = false;
    for (int i = 0; i < text.length; i++) {
      if (text[i].toLowerCase() != text[i].toUpperCase()) {
        hasLetter = true;
        break;
      }
    }

    // Vérifie si la chaîne contient uniquement des caractères autorisés
    const allowedChars =
        "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\n \"-_?)&('><:,.!;+-àâéèêëîïôœùûüç*/%£\$";
    bool hasOnlyAllowedChars = true;
    for (int i = 0; i < text.length; i++) {
      if (!allowedChars.contains(text[i])) {
        hasOnlyAllowedChars = false;
        break;
      }
    }

    return hasLetter && hasOnlyAllowedChars;
  }

  void _goBack() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Auth()));
  }

  void createUserAccount() async {
    var response = await authObject.AuthCheckAndCreate.createUserAccount(
        email.trim(), password.trim(), name.trim());
    if (response == null) {
      setState(() {
        _isAuthenticating = false;
      });
      globals.successMessage = "Compte crée avec succes ! Un email d'activation de compte vous a été envoyé.  ";
    } else {
      globals.errorMessage = response;
    }

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Auth()));
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: _goBack,
            icon: const Icon(
              Icons.arrow_back,
            ),
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
          title: const Text("Creation de compte",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontFamily: "Roboto",
                  fontSize: 20)),
          elevation: 0.0,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: const SizedBox(
                          height: 50,
                          child: Image(
                            image: AssetImage("resources/login.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text("S'INSCRIRE",
                          style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).primaryColor)),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Container(
                          child: Form(
                              key: _formGlobalKey,
                              child: Column(children: [
                                TextFormField(
                                  validator: (value) {
                                    if (value?.trim() == null ||
                                        value!.isEmpty ||
                                        isValidText(value.trim()) == false) {
                                      return 'Verifiez ce que vous avez saisie...';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      labelText: "Saisir votre nom complet"),
                                  onChanged: (value) => {
                                    setState(() {
                                      name = value;
                                    })
                                  },
                                ),
                                TextFormField(
                                  validator: (value) => (email.isEmpty ||
                                          !emailRegExp.hasMatch(email)
                                      ? 'Vérifier l\'email saisi...'
                                      : null),
                                  decoration: const InputDecoration(
                                      labelText: "Saisir une adresse email"),
                                  onChanged: (value) => {
                                    setState(() {
                                      email = value;
                                    })
                                  },
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                TextFormField(
                                  validator: (value) => (password.length <= 5
                                      ? 'Mots de passe trop court ! '
                                      : null),
                                    obscureText: _obscureText,
                                    decoration: InputDecoration(
                                      hintText: "Saisir un mots de passe",
                                      suffixIcon: InkWell(
                                        onTap: () => setState(() {
                                          _obscureText = !_obscureText;
                                        }),
                                        child: Icon(_obscureText
                                            ? Icons.visibility_off
                                            : Icons.visibility),
                                      )
                                    ),
                                  onChanged: (value) => {
                                    setState(() {
                                      password = value;
                                    })
                                  },
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                ElevatedButton(
                                  onPressed: email.isEmpty ||
                                          password.isEmpty ||
                                          name.isEmpty
                                      ? null
                                      : () {
                                          if (_formGlobalKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              _isAuthenticating = true;
                                            });
                                            createUserAccount();
                                          } else {
                                            print('form non validé');
                                          }
                                        },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 5.0,
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    fixedSize: Size(200, 50),
                                  ),
                                  child: _isAuthenticating
                                      ? CircularProgressIndicator()
                                      : Text(
                                          'S\'inscrire'.toUpperCase(),
                                        ),
                                ),
                              ])))
                    ]))));
  }
}
