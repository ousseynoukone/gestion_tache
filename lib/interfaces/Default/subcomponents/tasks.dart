import 'package:flutter/material.dart';
import 'package:gestion_tache/http/http_task.dart';
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
  @override
  void initState() {
    //  print('init');
    super.initState();
    globals.tasks = HttpTask.fetchTasks();
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
        
        FutureBuilder<List<Task>>(
            future: globals.tasks,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return TaskItem(task: snapshot.data!.elementAt(index));
                    });
              }
              return const CircularProgressIndicator();
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
