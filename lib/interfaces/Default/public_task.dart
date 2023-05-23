import 'package:gestion_tache/interfaces/Default/subcomponents/public_task_details.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:gestion_tache/http/http_task.dart';
import 'package:gestion_tache/http/http_task_firebase.dart';
import 'package:intl/intl.dart';
import '../../globals/globals.dart' as globals;

import 'accueil.dart';
import 'add_task.dart';
import 'models/task.dart';

class PublicTask extends StatefulWidget {
  const PublicTask({super.key});

  @override
  State<PublicTask> createState() => _PublicTaskState();
}

class _PublicTaskState extends State<PublicTask> {
  void _goBack() async {
    globals.task = null;
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Accueil()));
  }

  Future<List<Task>>? tasks;
  List<int> nbTask = [0, 0, 0, 0];
  void initState() {
    super.initState();
    //globals.tasks =

    globals.onApiModeChangedPublicTask = (value) {
      setState(() {
        initializeTasks();
      });
    };
    initializeTasks();
  }

  void initializeTasks() {
    if (globals.apiMode == false) {
      setState(() {
        tasks = HttpFirebase.getTasks();

        HttpFirebase.fetchTasksNumbers().then((value) {
          setState(() {
            nbTask = value;
          });
        });
      });
    } else {
      setState(() {
        tasks = HttpTask.fetchTasks();

        HttpTask.fetchTasksNumbers().then((value) {
          setState(() {
            nbTask = value;
          });
        });
      });
    }
  }

  void refresh() {
    initializeTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: _goBack,
          icon: const Icon(
            Icons.arrow_back,
          ),
          color: Theme.of(context).primaryColor,
        ),
        title: Text(
          "Tâches publiques",
          style: TextStyle(
              color: Theme.of(context).primaryColor, fontFamily: 'Raleway'),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Column(children: [
        Container(
          margin: const EdgeInsets.all(20.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.all(10.0),
              alignment: Alignment.center,
              constraints: const BoxConstraints(minWidth: 350, minHeight: 100),
              color: const Color.fromARGB(255, 68, 21, 151),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Les tâches publiques",
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Nombre de tache total : ${nbTask[0]}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                      Text(
                        "Nombre de tâche échues : ${nbTask![3] != null ? nbTask![3] : '0'}",
                        style: const TextStyle(
                            color: Colors.white,
                            // fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                      Text(
                        "Nombre de tâche en cours : ${nbTask![2] != null ? nbTask![2] : '0'}",
                        style: const TextStyle(
                            color: Colors.white,
                            // fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                      Text(
                        "Nombre de tâche en attente : ${nbTask![1] != null ? nbTask![1] : '0'}",
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
          margin: EdgeInsets.only(left: 20),
          alignment: Alignment.bottomLeft,
          child: Row(
            children: [
              Text(
                "Liste des Tâches",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  refresh();
                },
                child: Icon(Icons.refresh),
              ),
              SizedBox(width: 20),
            ],
          ),
        ),
        Expanded(
            child: RefreshIndicator(
                onRefresh: () async {
                  refresh();
                },
                child: SingleChildScrollView(
                  child: FutureBuilder<List<Task>>(
                      future: tasks,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasData) {
                          if (snapshot.data?.isEmpty == true) {
                            return SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 20),
                                  Text("Il n'y a  aucune tâche publique "),
                                ],
                              ),
                            );
                          } else {
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.all(8),
                                itemCount: snapshot.data?.length,
                                itemBuilder: (context, index) {
                                  return TaskItem(
                                      task: snapshot.data!.elementAt(index));
                                });
                          }
                        }
                        return const SizedBox.shrink();
                      }),
                )))
      ]),
    );
  }
}

class TaskItem extends StatelessWidget {
  final Task task;
  const TaskItem({super.key, required this.task});

  String formatDateEcheance() {
    var f = DateFormat("dd / MM / yyyy hh:mm:ss").format(task.date_echeance);
    return f;
  }

  String formatDateDebut() {
    var f = DateFormat("dd / MM / yyyy hh:mm:ss").format(task.date_debut);
    return f;
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
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 100),
                    child: Text(
                      'De la part de : ${task.username}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
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
                    "Début: ${formatDateDebut()}",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Échéance: ${formatDateEcheance()}",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
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
                            )
                ],
              ),
              ElevatedButton.icon(
                onPressed: () {
                  globals.task = task;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PublicTaskDetails(),
                    ),
                  );
                },
                icon: const Icon(Icons.arrow_forward_ios),
                label: const Text(""),
                style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll(Colors.white),
                  foregroundColor: MaterialStatePropertyAll(
                    Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
