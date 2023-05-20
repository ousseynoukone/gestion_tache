import 'package:flutter/material.dart';
import 'package:Groupe_8/http/http_task.dart';
import 'package:Groupe_8/http/http_task_firebase.dart ';
import 'package:Groupe_8/interfaces/Default/add_task.dart';
import 'package:Groupe_8/interfaces/Default/models/task.dart';
import 'package:intl/intl.dart';
import '../../../globals/globals.dart' as globals;

class Tasks extends StatefulWidget {
  final VoidCallback
      onDelete2; // Callback pour mettre a jour le  nombre des taches

  const Tasks({super.key, required this.onDelete2});

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
                      return TaskItem(
                        task: snapshot.data!.elementAt(index),
                        onDelete: () {
                          // Fonction de suppression appelée depuis le widget TaskItem
                          setState(() {
                            print("calback called suppression called");
                            globals.tasks =
                                HttpFirebase.getTaskByUser(globals.user?.uid);
                            widget.onDelete2();
                          });
                        },
                      );
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
  final VoidCallback onDelete; // Callback pour la suppression

  const TaskItem({super.key, required this.task, required this.onDelete});
  String formatDate() {
    var f = DateFormat("dd / MM / yyyy hh:mm:ss").format(task.date_echeance);
    return f;
  }

  void delete(id) async {
    await HttpFirebase.deleteTask(id).then((value) =>
        value == true ? onDelete() : print("echec de la suppresion"));
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
              task.title.length <= 35
                  ? Text(task.title)
                  : Text(task.title.substring(0, 35) + '...'),
              const SizedBox(height: 10.0),
              Text(formatDate())
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
              SizedBox(
                width: 10,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  delete(task.doc_id);
                },
                icon: const Icon(Icons.delete_rounded),
                label: const Text(""),
                style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll(Colors.white),
                  foregroundColor:
                      MaterialStatePropertyAll(Theme.of(context).primaryColor),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
