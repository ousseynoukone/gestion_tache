import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Groupe_8/globals/globals.dart';
import 'package:Groupe_8/interfaces/Default/models/task.dart';
import 'package:Groupe_8/interfaces/Default/models/task.dart';

class HttpFirebase {
  HttpFirebase();

  static Future<bool> TaskUpdateState(int state, id) async {
    CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');
    try {
      await tasks.doc(id).update({
        'state': state,
      });
      return true;
    } catch (ex) {
      print(ex);
    }
    return false;
  }

  static Future<List<Task>> getTaskByUser(userID) async {
    CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');
    List<Task> taskList = [];

    QuerySnapshot querySnapshot = await tasks.get();
    for (var doc in querySnapshot.docs) {
      var dateEcheance = (doc['date_echeance'] as Timestamp).toDate();
      var dateDebut = (doc['date_debut'] as Timestamp).toDate();
      print(DateTime.now().isAfter(dateDebut));
      if (DateTime.now().isAfter(dateDebut) ||
          DateTime.now().isAtSameMomentAs(dateDebut)) {
        await TaskUpdateState(
            1, doc.id); // Update task state to indicate it is in progress
      }

      print(DateTime.now().isAtSameMomentAs(dateEcheance) ||
          DateTime.now().isAfter(dateEcheance));

      if (DateTime.now().isAtSameMomentAs(dateEcheance) ||
          DateTime.now().isAfter(dateEcheance)) {
        await TaskUpdateState(
            2, doc.id); // Update task state to indicate it is completed
      }

      if (userID == doc['userID'] &&
          (doc['status'] == 2 || doc['status'] == 0)) {
        var dateEcheance = (doc['date_echeance'] as Timestamp).toDate();
        var dateDebut = (doc['date_debut'] as Timestamp).toDate();
        try {
          var task = Task(
            id: doc['id'].toString(),
            title: doc['title'],
            state: doc['state'],
            description: doc['description'],
            date_echeance: doc['date_echeance'].toDate(),
            date_debut: doc['date_debut'].toDate(),
            doc_id: doc.id,
          );
          taskList.add(task);
        } catch (e) {
          print('Error creating task: $e');
        }
      }
    }

    return taskList;
  }

  static Future<List<Task>> getTasks() async {
    CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');
    List<Task> taskList = [];

    QuerySnapshot querySnapshot = await tasks.get();
    for (var doc in querySnapshot.docs) {
      if (doc['status'] == 1 || doc['status'] == 2) {
        var dateEcheance = (doc['date_echeance'] as Timestamp).toDate();
        var dateDebut = (doc['date_debut'] as Timestamp).toDate();
        try {
          var task = Task(
            state: doc['state'],
            status: doc['status'],
            id: doc['id'].toString(),
            title: doc['title'],
            username: doc['username'],
            description: doc['description'],
            date_echeance: doc['date_echeance'].toDate(),
            date_debut: doc['date_debut'].toDate(),
            doc_id: doc.id,
          );
          print(task);

          taskList.add(task);
        } catch (e) {
          print('Error creating task: $e');
        }
      }
    }

    return taskList;
  }

  static Future<List<int>> fetchTasksNumber(userID) async {
    CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');
    List<int> number = [];
    int cpt = 0;
    int cpt1 = 0;
    int cpt2 = 0;
    int cpt3 = 0;
    await tasks.get().then((value) => value.docs.forEach((doc) {
          if (userID == doc['userID'] &&
              (doc['status'] == 2 || doc['status'] == 0)) {
            cpt += 1;
          }
          if (userID == doc['userID'] &&
              (doc['status'] == 2 || doc['status'] == 0) &&
              doc['state'] == 0) {
            cpt1 += 1;
          }
          if (userID == doc['userID'] &&
              (doc['status'] == 2 || doc['status'] == 0) &&
              doc['state'] == 1) {
            cpt2 += 1;
          }

          if (userID == doc['userID'] &&
              (doc['status'] == 2 || doc['status'] == 0) &&
              doc['state'] == 2) {
            cpt3 += 1;
          }
        }));
    number.add(cpt);
    number.add(cpt1);
    number.add(cpt2);
    number.add(cpt3);
    return number;
  }

  static Future<List<int>> fetchTasksNumbers() async {
    CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');
    List<int> listNumber = [];
    var number = 0;
    var number1 = 0;
    var number2 = 0;
    var number3 = 0;

    await tasks.get().then((value) => value.docs.forEach((doc) {
          if (doc['status'] == 1 || doc['status'] == 2) {
            number += 1;
          }

          if ((doc['status'] == 2 || doc['status'] == 1) && doc['state'] == 0) {
            number1 += 1;
          }
          if ((doc['status'] == 2 || doc['status'] == 1) && doc['state'] == 1) {
            print("1");
            number2 += 1;
          }

          if ((doc['status'] == 2 || doc['status'] == 1) && doc['state'] == 2) {
            number3 += 1;
          }
        }));
    listNumber.add(number);
    listNumber.add(number1);
    listNumber.add(number2);
    listNumber.add(number3);
    return listNumber;
  }

  static Future<bool> addTaskByUser(Task task, String? userID) async {
    CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');
    QuerySnapshot querySnapshot = await tasks.get();
    var number = 0;
    for (var doc in querySnapshot.docs) {
      if (doc["userID"] != 0) {
        number += 1;
      }
    }
    try {
      await tasks.add({
        'id': number,
        'title': task.title,
        'state': task.state,
        'status': task.status,
        'username': task.username,
        'description': task.description,
        'date_echeance': task.date_echeance,
        'date_debut': task.date_debut,
        'userID': userID,
      });
      return true;
    } catch (exception) {
      return false;
    }
  }

  static Future<bool> deleteTask(id) async {
    CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');
    try {
      await tasks.doc(id).delete();
      return true;
    } catch (error) {
      return false;
    }
  }

  static Future<bool> updateTask(id, Task task) async {
    CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');
    try {
      await tasks.doc(id).update({
        'title': task.title,
        'description': task.description,
        'date_echeance': task.date_echeance,
        'date_debut': task.date_debut,
        'state': task.state,
        'status': task.status,
      });
      return true;
    } catch (error) {
      return false;
    }
  }
}
