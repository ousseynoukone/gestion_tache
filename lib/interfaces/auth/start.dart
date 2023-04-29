import 'package:flutter/material.dart';

import 'auth.dart';

class Start extends StatefulWidget {

  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
              "Bienvenue dans votre application de  gestion des tâches",
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 19),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 65.0,
          ),
          ElevatedButton(
            onPressed: () {
                        Navigator.push(
        context, MaterialPageRoute(builder: (context) =>  const Auth()));
            },
            style: ElevatedButton.styleFrom(
              elevation: 5.0,
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Theme.of(context).secondaryHeaderColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              minimumSize: const Size(200, 50),
            ),
            child: Text(
              ' Allons-y ! '.toUpperCase(),
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      )),
    );
  }
}
