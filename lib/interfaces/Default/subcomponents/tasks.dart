import 'package:flutter/material.dart';
import 'package:gestion_tache/interfaces/Default/add_task.dart';
import 'package:gestion_tache/interfaces/Default/models/task.dart';
import 'package:intl/intl.dart';
import '../../../globals/globals.dart' as globals;

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _Tasks();
}

class _Tasks extends State<Tasks> {
  List<Task> tasks = [];

  List<Task> fetchTasks() {
    return <Task>[
      Task(
          id: 1,
          title: "title",
          description: "description",
          date_echeance: new DateTime.now().add(const Duration(days: 30))),
      Task(
          id: 2,
          title: "title2",
          description: "description2",
          date_echeance: new DateTime.now().add(const Duration(days: 10)))
    ];
  }

  @override
  void initState() {
    super.initState();
    tasks = fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Liste des Taches",
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
            children: [
              Text("${task.title}"),
              SizedBox(height: 10.0),
              Text("${formatDate()}")
            ],
          ),
          ElevatedButton.icon(
            onPressed: () {
              globals.task = this.task;
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddTask()));
            },
            icon: Icon(Icons.arrow_forward_ios),
            label: Text(""),
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.white),
              foregroundColor:
                  MaterialStatePropertyAll(Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
