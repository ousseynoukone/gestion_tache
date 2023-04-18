import 'package:flutter/material.dart';
import 'package:gestion_tache/interfaces/Default/add_task.dart';
import 'package:gestion_tache/interfaces/Default/subcomponents/tasks.dart';
import 'package:gestion_tache/http/http_task.dart';

class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  var number;

  void initState() {
    super.initState();
    //globals.tasks =

    HttpTask.fetchTasksNumber().then((value) {
      setState(() {
        number = value;
      });
    });
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
            icon: Icon(
              Icons.menu,
            ),
            color: Theme.of(context).primaryColor,
          ),
          actions: [
            IconButton(
              style: ButtonStyle(),
              onPressed: null,
              icon: const Icon(
                Icons.notifications_none,
              ),
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    alignment: Alignment.center,
                    constraints: BoxConstraints(minWidth: 350, minHeight: 100),
                    color: Color.fromARGB(255, 68, 21, 151),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nombre de tache total",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              number != null ? '$number' : '0',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Tasks(),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          height: 80.0,
          shape: const CircularNotchedRectangle(),
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Theme.of(context).primaryColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                label: 'Calendar',
                backgroundColor: Theme.of(context).primaryColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble_outline),
                label: 'Business',
                backgroundColor: Theme.of(context).primaryColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
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
