import 'package:gestion_tache/interfaces/Default/models/task.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpTask {
  static const String BASE_URL = "http://10.0.2.2:5050/";

  static Future<List<Task>> fetchTasks() async {
    String endpoint = "api/v1/tasks";
    List<Task> tasks = [];
    final response = await http.get(Uri.parse(BASE_URL + endpoint));

    List jsonParsed = jsonDecode(response.body);
    for (int i = 0; i < jsonParsed.length; i++) {
      print(jsonParsed[i]);
      tasks.add(Task.fromJson(jsonParsed[i]));
    }
    return tasks;
  }

  static Future<List<Task>> addTask(Task task) async {
    String endpoint = "api/v1/tasks";
    var url = Uri.parse(BASE_URL + endpoint);
    final response = await http.post(url, body: task.toBody());

    return fetchTasks();
  }
}
