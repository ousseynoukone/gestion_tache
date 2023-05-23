//import 'dart:js_util';
import 'package:Groupe_8/interfaces/auth/sharedPreference.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Groupe_8/interfaces/Default/public_task.dart';
import 'package:Groupe_8/interfaces/Default/add_task.dart';
import 'package:Groupe_8/interfaces/Default/subcomponents/tasks.dart';
import 'package:Groupe_8/http/http_task_firebase.dart';
import 'package:Groupe_8/http/http_task.dart';
import 'package:Groupe_8/globals/globals.dart' as globals;
import 'package:Groupe_8/interfaces/Default/public_task.dart';
import 'package:Groupe_8/interfaces/Default/add_task.dart';
import 'package:Groupe_8/interfaces/Default/subcomponents/tasks.dart';
import 'package:Groupe_8/http/http_task_firebase.dart';
import 'package:Groupe_8/globals/globals.dart' as globals;

import '../auth/auth.dart';

class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  bool _switchValue = false;

  void _deleteLoginCredentials() {
    sharedPreference.removeUserCredential();
  }

  void _goBack() async {
    globals.task = null;
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Accueil()));
  }

  @override
  void initState() {
    super.initState();
    //globals.tasks =
    globals.onApiModeChangedForTaskNumber = (value) {
      setState(() {
        initializeTasks();
      });
    };
    initializeTasks();
  }

  void initializeTasks() {
    if (globals.apiMode == false) {
      setState(() {
        HttpFirebase.fetchTasksNumber(globals.user?.uid).then((value) {
          setState(() {
            globals.number = value;
          });
        });
      });
    } else {
      setState(() {
        HttpTask.fetchTasksNumberByUser(globals.user?.uid).then((value) {
          setState(() {
            globals.number = value;
          });
        });
      });
    }
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _goToAddDartPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AddTask()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Page d'accueil",
            style: TextStyle(
                color: Theme.of(context).primaryColor, fontFamily: 'Raleway'),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
            onPressed: null,
            icon: const Icon(
              Icons.home,
            ),
            color: Theme.of(context).primaryColor,
          ),
          actions: [
            IconButton(
              style: const ButtonStyle(),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                _deleteLoginCredentials();
                globals.name = "";
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Auth()));
              },
              icon: const Icon(
                Icons.logout_rounded,
              ),
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.all(20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  alignment: Alignment.center,
                  constraints:
                      const BoxConstraints(minWidth: 350, minHeight: 100),
                  color: const Color.fromARGB(255, 68, 21, 151),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Switch(
                                value: globals.apiMode,
                                onChanged: (bool value) {
                                  setState(() {
                                    _switchValue = value;
                                    globals.apiMode = value;
                                    globals.onApiModeChanged(value);
                                    globals.onApiModeChangedPublicTask(value);
                                    globals.onApiModeChangedForPublicTaskNumber(
                                        value);
                                    globals
                                        .onApiModeChangedForTaskNumber(value);
                                  });
                                },
                              ),
                              Text(
                                globals.apiMode
                                    ? 'Mode API activé'
                                    : 'Mode API désactivé',
                                style: TextStyle(
                                    fontSize: 16,
                                    color:
                                        Theme.of(context).secondaryHeaderColor),
                              ),
                            ],
                          ),
                          globals.name.isEmpty
                              ? Text(
                                  "Bienvenue ${globals.user?.displayName}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )
                              : Text(
                                  "Bienvenue ${globals.name}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Nombre de tâche total : ${globals.number![0] != null ? globals.number![0] : '0'}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                          Text(
                            "Nombre de tâche échues : ${globals.number![3] != null ? globals.number![3] : '0'}",
                            style: const TextStyle(
                                color: Colors.white,
                                // fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                          Text(
                            "Nombre de tâche en cours : ${globals.number![2] != null ? globals.number![2] : '0'}",
                            style: const TextStyle(
                                color: Colors.white,
                                // fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                          Text(
                            "Nombre de tâche en attente : ${globals.number![1] != null ? globals.number![1] : '0'}",
                            style: const TextStyle(
                                color: Colors.white,
                                // fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 20, bottom: 10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PublicTask()));
                },
                style: ElevatedButton.styleFrom(
                  elevation: 5.0,
                  backgroundColor: Theme.of(context).primaryColor,
                  fixedSize: const Size(170, 50),
                ),
                child: Text(
                  'Tâches publiques'.toUpperCase(),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              alignment: Alignment.bottomLeft,
              child: Text(
                "Liste des Tâches",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Tasks(onDelete2: () {
                  HttpFirebase.fetchTasksNumber(globals.user?.uid)
                      .then((value) {
                    setState(() {
                      print(value);
                      globals.number = value;
                    });
                  });
                }),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          height: 80.0,
          shape: const CircularNotchedRectangle(),
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: 'Home',
                backgroundColor: Theme.of(context).primaryColor,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.calendar_today),
                label: 'Calendar',
                backgroundColor: Theme.of(context).primaryColor,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.chat_bubble_outline),
                label: 'Business',
                backgroundColor: Theme.of(context).primaryColor,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.person),
                label: 'School',
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped,
          ),
        ),
        floatingActionButton: FloatingActionButton.small(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 10.0,
          onPressed: _goToAddDartPage,
          tooltip: 'Increment Counter',
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
      ),
    );
  }
}
