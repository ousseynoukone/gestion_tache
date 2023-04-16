import 'package:flutter/material.dart';
import 'package:gestion_tache/interfaces/Default/accueil.dart';
import 'package:gestion_tache/interfaces/Default/add_task.dart';
import 'package:gestion_tache/interfaces/home.dart';
import './globals/globals.dart' as globals;

void main() {
  globals.username = "";
  globals.password = "";

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Gestionnaire de tache',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 68, 21, 151),
        secondaryHeaderColor: Colors.white,
      ),
      //home: const Home(),
      home: const AddTask(),
    );
  }
}
