import 'package:flutter/material.dart';
import 'package:gestion_tache/interfaces/auth/auth.dart';

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
  final RegExp emailRegExp = RegExp(r"[a-z0-9\._-]+@[a-z0-9\._-]+\.[a-z]+");
  void _goBack() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const Auth()));
  }

  void createUserAccount() async {
    print("hihi");
    var response =
        await authObject.AuthCheckAndCreate.createUserAccount(email, password);

    Navigator.push(context, MaterialPageRoute(builder: (context) => const Auth()));
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
                          height: 62,
                          child: Image(
                            image: AssetImage("resources/login.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text("S'INSCRIRE",
                          style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).primaryColor)),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                          child: Form(
                              key: _formGlobalKey,
                              child: Column(children: [
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
                                  height: 10.0,
                                ),
                                TextFormField(
                                  validator: (value) => (password.length <= 5
                                      ? 'Mots de passe trop court ! '
                                      : null),
                                  decoration: const InputDecoration(
                                      labelText: "Saisir un mots de passe"),
                                  onChanged: (value) => {
                                    setState(() {
                                      password = value;
                                    })
                                  },
                                ),
                                ElevatedButton(
                                  onPressed: email.isEmpty || password.isEmpty
                                      ? null
                                      : () {
                                          if (_formGlobalKey.currentState!
                                              .validate()) {
                                            createUserAccount();
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
                                    'S\'inscrire'.toUpperCase(),
                                  ),
                                ),
                              ])))
                    ]))));
  }
}
