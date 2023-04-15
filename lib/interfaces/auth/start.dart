import 'package:flutter/material.dart';

class Start extends StatefulWidget {
  final Function(int) onNext;

  const Start({super.key, required this.onNext});

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
          Padding(
            padding: EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                height: 400,
                child: Image(
                  image: NetworkImage("https://static.vecteezy.com/system/resources/previews/003/216/687/original/lets-start-big-words-concept-with-team-people-and-rocket-free-vector.jpg"),
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
              print("gfhhf");
              widget.onNext(1);
            },
            child: Text(
              ' Allons-y ! '.toUpperCase(),
              style: TextStyle(fontSize: 15),
            ),
            style: ElevatedButton.styleFrom(
              elevation: 5.0,
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Theme.of(context).secondaryHeaderColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              minimumSize: Size(200, 50),
            ),
          ),
        ],
      )),
    );
  }
}
