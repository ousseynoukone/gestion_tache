import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gestion_tache/interfaces/Default/accueil.dart';
import 'firebase_options.dart';
import 'interfaces/auth/start.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // add this line
  await Firebase.initializeApp(
    name: 'task-app',
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        primaryColor: const Color.fromARGB(255, 68, 21, 151),
        secondaryHeaderColor: Colors.white,
        primaryColorDark: Colors.redAccent,
      ),
      //home: const Home(),
      home: const Start(),
    );
  }
}
