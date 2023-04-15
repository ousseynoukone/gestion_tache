import 'package:flutter/material.dart';
import '../../globals/globals.dart' as globals;



class Accueil extends StatefulWidget {

  const Accueil({super.key});

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                height: 400,
                child: const Image(
                  image: AssetImage("resources/start.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 25.0,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "Bienvenue ${globals.errorMessage} dans votre application de  gestion des tâches",
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
        ],
      )),
    );
  }
}
