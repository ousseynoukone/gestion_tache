import 'package:flutter/material.dart';
import 'package:gestion_tache/http/http_task.dart';
import 'package:gestion_tache/http/http_task_firebase.dart ';
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

    globals.tasks = HttpFirebase.getTaskByUser(globals.user?.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [],
        ),
        FutureBuilder<List<Task>>(
          future: globals.tasks,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              if (snapshot.data?.isEmpty == true) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 75, top: 20),
                          child: Text("Vous n'avez enregistré aucune tâche"))
                    ]);
              } else {
                return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return TaskItem(task: snapshot.data!.elementAt(index));
                    });
              }
            }
            return const SizedBox.shrink();
          },
        )
      ]),
    );
  }
}

class TaskItem extends StatelessWidget {
  final Task task;
  const TaskItem({super.key, required this.task});

  String formatDate() {
    var f = DateFormat("dd / MM / yyyy hh:mm:ss").format(task.date_echeance);
    return f;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(task.title),
              const SizedBox(height: 10.0),
              Text(formatDate())
            ],
          ),
          ElevatedButton.icon(
            onPressed: () {
              globals.task = task;
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddTask()));
            },
            icon: const Icon(Icons.arrow_forward_ios),
            label: const Text(""),
            style: ButtonStyle(
              backgroundColor: const MaterialStatePropertyAll(Colors.white),
              foregroundColor:
                  MaterialStatePropertyAll(Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
