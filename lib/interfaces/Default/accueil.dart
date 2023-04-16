import 'package:flutter/material.dart';
import 'package:gestion_tache/interfaces/Default/models/task.dart';
import 'package:intl/intl.dart';

class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 3: Settings',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
        body: Column(
          children: [
            ProgressIndicator(),
            Tasks(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
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
    );
  }
}

class ProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.center,
          constraints: BoxConstraints(minWidth: 350, minHeight: 100),
          color: Color.fromARGB(255, 68, 21, 151),
          child: const Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Résumé des progrès d'aujourd'hui ",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "15 Taches ",
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
    );
  }
}

class Tasks extends StatelessWidget {
  final List<Task> tasks = <Task>[
    Task(
        id: 1,
        title: "title",
        description: "description",
        date_echeance: new DateTime.now()),
    Task(
        id: 2,
        title: "title2",
        description: "description2",
        date_echeance: new DateTime.now())
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Taches du Jour",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            ElevatedButton(
              onPressed: null,
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.white),
              ),
              child: Text(
                "Voir Tout",
              ),
            ),
          ],
        ),
        ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            itemCount: tasks.length,
            itemBuilder: (BuildContext context, int index) {
              return TaskItem(task: tasks[index]);
            }),
      ]),
    );
  }
}

class TaskItem extends StatelessWidget {
  final Task task;
  TaskItem({required this.task});

  String formatDate() {
    var f = DateFormat("dd / MM / yyyy hh:mm:ss").format(task.date_echeance);
    return f;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text("${task.title}"), Text("${formatDate()}")],
          ),
          ElevatedButton.icon(
            onPressed: null,
            icon: Icon(Icons.arrow_forward_ios),
            label: Text(""),
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
