import 'package:flutter/material.dart';
import 'package:gestion_tache/interfaces/Default/accueil.dart';
import '../../globals/globals.dart' as globals;

class Password extends StatefulWidget {
  final Function(int) onNext;
  const Password({super.key, required this.onNext});

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {

  void checkCredentials(username, password, context) {
    String trueUsername = "admin@gmail.com";
    String truePassword = "passer123";
    String trueName = "Ousseynou K.";

    if (username == trueUsername && password == truePassword) {
      globals.errorMessage = trueName;
      Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Accueil()),
            );
    } else {
      globals.errorMessage = "Mot de Passe ou Email Incorrect(s)";
      widget.onNext(1);
    }
  }

  String _inputContent = "";
  bool _obscureText = true;
  final GlobalKey<FormState> _formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(''),
          elevation: 0.0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: IconButton(
            onPressed: () {
              widget.onNext(1);
            },
            icon: Icon(
              Icons.arrow_back,
            ),
            color: Colors.black,
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 30.0,
            ),
            child: Column(
              children: [
                //   SizedBox(
                //     height: 200.0,
                //   ),
                Text(
                  'Mot de passe'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Form(
                  key: _formGlobalKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Entrez votre mot de passe',
                      ),
                      SizedBox(
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
                            //    print("Passwordg ${globals.password}");
                            //  print("Username : ${globals.username}");
                            checkCredentials(
                                globals.username, globals.password, context);
                          }
                        },
                        child: Text(
                          'Suivant'.toUpperCase(),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 5.0,
                          backgroundColor: Theme.of(context).primaryColor,
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
