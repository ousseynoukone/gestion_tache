import 'package:flutter/material.dart';
import 'package:gestion_tache/interfaces/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestionnaire de tache',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 68, 21, 151),
        secondaryHeaderColor: Colors.white,
      ),
      home: const Home(),
    );
  }
}
