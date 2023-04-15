import 'package:flutter/material.dart';
import '../../globals/globals.dart' as globals;

class Auth extends StatefulWidget {
  final Function({int index,String? errorMessage}) onNext;


 const  Auth({super.key, required this.onNext });

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final GlobalKey<FormState> _formGlobalKey = GlobalKey<FormState>();

  String adr_email = "";
  final RegExp emailRegExp = RegExp(r"[a-z0-9\._-]+@[a-z0-9\._-]+\.[a-z]+");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(),
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 30.0,
            ),
            child: Column(
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Authentification'.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: '-'.toUpperCase(),
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
                  height: 10.0,
                ),
                Text(
                  'Merci de renseignez vos infos',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
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
                      ElevatedButton(
                        onPressed: adr_email.isEmpty ||
                                !emailRegExp.hasMatch(adr_email)
                            ? null
                            : () {
                                if (_formGlobalKey.currentState!.validate()) {
                                  print('form validé');
                                  widget.onNext(2);
                                } else {
                                  print('form non validé');
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
