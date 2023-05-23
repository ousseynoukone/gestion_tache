import 'package:flutter/material.dart';
import 'package:gestion_tache/http/http_task.dart';
import 'package:gestion_tache/http/http_task_firebase.dart ';
import 'package:gestion_tache/interfaces/Default/add_task.dart';
import 'package:gestion_tache/interfaces/Default/models/task.dart';
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
    globals.onApiModeChanged = (value) {
      setState(() {
        initializeTasks();
      });
    };
    initializeTasks();
  }

  void initializeTasks() {
    if (globals.apiMode == false) {
      setState(() {
        globals.tasks = HttpFirebase.getTaskByUser(globals.user?.uid);
      });
    } else {
      setState(() {
        globals.tasks = HttpTask.fetchTasksByUser(globals.user?.uid);
      });
    }
  }

  void refresh() {
    setState(() {
      initializeTasks();
    });
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
                            initializeTasks();

                            widget.onDelete2();
                            initializeTasks();
                          });
                        },
                        fetchTask: () async {
                          initializeTasks();
                          widget.onDelete2();
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
  final VoidCallback fetchTask; // Callback pour la suppression

  const TaskItem(
      {super.key,
      required this.task,
      required this.onDelete,
      required this.fetchTask});
  String formatDateEcheance() {
    var f = DateFormat("dd / MM / yyyy hh:mm:ss").format(task.date_echeance);
    return f;
  }

  void updateTask(int state, id) async {
    await HttpFirebase.TaskUpdateState(state, id);
    fetchTask();
  }

  String formatDateDebut() {
    var f = DateFormat("dd / MM / yyyy hh:mm:ss").format(task.date_debut);
    return f;
  }

  void delete(id) async {
    await HttpFirebase.deleteTask(id).then((value) =>
        value == true ? onDelete() : print("echec de la suppresion"));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context)
              .primaryColor, // Set the background color of the container
          borderRadius: BorderRadius.circular(5.0), // Set the border radius
        ),
        margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  task.title.length <= 20
                      ? Text(
                          "Titre : " + task.title,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        )
                      : Text(
                          "Titre : " + task.title.substring(0, 20) + '...',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                  const SizedBox(height: 10.0),
                  Text(
                    "Début : ${formatDateDebut()}",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Échéance : ${formatDateEcheance()}",
                      style: const TextStyle(
                        color: Colors.white,
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  task.state == 0
                      ? Container(
                          height: 40,
                          width: 200,
                          child: Row(
                            children: [
                              Image.asset(
                                'resources/waiting.png',
                                fit: BoxFit.contain,
                              ),
                              Text(
                                ' En attente ',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        )
                      : task.state == 1
                          ? Container(
                              height: 40,
                              width: 200,
                              child: Row(
                                children: [
                                  Image.asset(
                                    'resources/loading.png',
                                    fit: BoxFit.contain,
                                  ),
                                  Text(
                                    ' En cours ',
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              height: 40,
                              width: 200,
                              child: Row(
                                children: [
                                  Image.asset(
                                    'resources/done.png',
                                    fit: BoxFit.contain,
                                  ),
                                  Text(
                                    ' Échu ',
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    color: task.state == 1 ? Colors.red : Colors.white,
                    onPressed: () {
                      if (task.state == 1) {
                        updateTask(2, task.doc_id);
                        fetchTask();
                      } else if (task.state == 0) {
                        updateTask(1, task.doc_id);
                        fetchTask();
                      }
                    },
                    icon: Icon(
                      task.state == 1
                          ? Icons.stop
                          : task.state == 0
                              ? Icons.play_arrow
                              : Icons.done_outline_rounded,
                      size: 30,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      globals.task = task;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddTask()));
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios,
                    ), // Set a custom size for the icon
                    label: const SizedBox.shrink(),
                    style: ButtonStyle(
                      // Set the minimum size of the button
                      // padding: EdgeInsets.zero, // Remove any padding
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      foregroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor),
                      // Set a custom size for the icon
                    ),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      delete(task.doc_id);
                    },
                    icon: const Icon(Icons.delete_rounded),
                    label: const Text(""),
                    style: ButtonStyle(
                      backgroundColor:
                          const MaterialStatePropertyAll(Colors.white),
                      foregroundColor: MaterialStatePropertyAll(
                          Theme.of(context).primaryColor),
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
