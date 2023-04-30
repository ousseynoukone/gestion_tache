import 'package:gestion_tache/interfaces/Default/subcomponents/public_task_details.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:gestion_tache/http/http_task.dart';
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
  int nbTask = 0;
  void initState() {
    super.initState();
    //globals.tasks =

    tasks = HttpTask.fetchTasks();

    HttpTask.fetchTasksNumber().then((value) {
      setState(() {
        nbTask = value;
        print(value);
      });
    });
  }

  void refresh() {
    setState(() {
      tasks = HttpTask.fetchTasks();
    });

    HttpTask.fetchTasksNumber().then((value) {
      setState(() {
        nbTask = value;
        print(value);
      });
    });
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
          "Taches publiques",
          style: TextStyle(
              color: Theme.of(context).primaryColor, fontFamily: 'Raleway'),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
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
                          Text(
                            "Les taches publiques",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Nombre de tache total : ${nbTask}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Liste des Taches",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    ),
                    RefreshIndicator(
                      onRefresh: () async {
                        refresh();
                        // Votre code pour rafraîchir les données
                      },
                      child: FutureBuilder<List<Task>>(
                          future: tasks,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(8),
                                  itemCount: snapshot.data?.length,
                                  itemBuilder: (context, index) {
                                    return TaskItem(
                                        task: snapshot.data!.elementAt(index));
                                  });
                            }
                            return const CircularProgressIndicator();
                          }),
                    )
                  ]),
            )
          ],
        ),
      ),
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PublicTaskDetails()));
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
