import 'package:flutter/material.dart';
import 'package:Groupe_8/interfaces/Default/accueil.dart';
import '../../globals/globals.dart' as globals;
import 'auth.dart';
import 'authEmailPasswordCheck.dart' as authObject;

class Password extends StatefulWidget {
  const Password({super.key});

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  void checkCredentials(email, password) async {
    try {
      var response =
          await authObject.AuthCheckAndCreate.userLogIn(email, password);
      if (response == null) {
        setState(() {
          _isAuthenticating = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Accueil()),
        );
      } else if (response == "false")
      {
                globals.errorMessage = "Veillez confirmer votre adresse email ! ";
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Auth()));

      }
      
      else {
        print(response);
        globals.errorMessage = "Adresse email ou/et mots de passe incorrecte .";
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Auth()));
      }
    } catch (e) {}

    // if (username == trueUsername && password == truePassword) {
    //   globals.errorMessage = trueName;
    //   Navigator.push(
    //           context,
    //           MaterialPageRoute(builder: (context) => const Accueil()),
    //         );
    // } else {
    //   globals.errorMessage = "Mot de Passe ou Email Incorrect(s)";
    //   widget.onNext(1);
    // }
  }

  void resetPassword(email) async {
    var result =
        await authObject.AuthCheckAndCreate.resetPassword(email: email);
    globals.successMessage =
        "Un email vous été envoyez pour réinitialiser votre mots de passe";
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Auth()));

    if (result == false) {
      globals.errorMessage =
          "L'addresse email saisie n'existe pas dans la base";
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Auth()));
    }
  }

  bool _isAuthenticating = false;

  String _inputContent = "";
  bool _obscureText = true;
  final GlobalKey<FormState> _formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'S\'authentifier',
          ),
          elevation: 0.0,
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Auth()));
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
            ),
            child: Column(
              children: [
                //   SizedBox(
                //     height: 200.0,
                //   ),
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
                      color: Theme.of(context).primaryColor,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                Form(
                  key: _formGlobalKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Entrez votre mot de passe',
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                            _inputContent = value;
                            globals.password = value;
                          });

                          //  print("input = ${_inputContent}");
                        },
                        validator: (value) => (_inputContent.isEmpty ||
                                _inputContent.length < 6)
                            ? 'Entrer un mot de passe avec 6 caractères minimum'
                            : null,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: () => setState(() {
                              _obscureText = !_obscureText;
                            }),
                            child: Icon(_obscureText
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          hintText: 'ex: !#2023@l3gl',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.0),
                            borderSide: const BorderSide(
                              color: Colors.amber,
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
                      ElevatedButton(
                        onPressed: () {
                          if (_formGlobalKey.currentState!.validate()) {
                            setState(() {
                              _isAuthenticating = true;
                            });
                            //    print("Passwordg ${globals.password}");
                            //  print("Username : ${globals.username}");
                            checkCredentials(globals.username.trim(),
                                globals.password.trim());
                          }
                        },
                        child: _isAuthenticating
                            ? CircularProgressIndicator(
                                strokeWidth: 2.0,
                              )
                            : Text('CONNEXION'),
                        style: ElevatedButton.styleFrom(
                          elevation: 5.0,
                          backgroundColor: Theme.of(context).primaryColor,
                          fixedSize: Size(200, 50),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          resetPassword(globals.username);
                        },
                        child: Text(
                          'Mots de passe oublé ?',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 100, 58, 250),
                            decoration: TextDecoration.underline,
                          ),
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
