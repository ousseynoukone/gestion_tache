import 'package:gestion_tache/interfaces/Default/models/task.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../globals/globals.dart' as globals;

class HttpTask {
  static const String BASE_URL = "http://10.0.2.2:5050/";

  static Future<List<Task>> fetchTasks() async {
    String endpoint = "api/v1/tasks";
    List<Task> tasks = [];
    final response = await http.get(Uri.parse(BASE_URL + endpoint));

    List jsonParsed = jsonDecode(response.body);
    for (int i = 0; i < jsonParsed.length; i++) {
      //print(jsonParsed[i]);
      tasks.add(Task.fromJson(jsonParsed[i]));
    }
    
    return tasks;
  }

  static Future<int> fetchTasksNumber() async {
    String endpoint1 = "api/v1/tasks/number";

    final response1 = await http.get(Uri.parse(BASE_URL + endpoint1));
    var number = json.decode(response1.body);
    return number['number'];
  }

  static Future<http.Response> deleteTask(id) async {
    String endpoint = "api/v1/taskDelete/$id";

    final http.Response response = await http.delete(
      Uri.parse(BASE_URL + endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    return response;
  }

  static void addTask(Task task) async {
    String endpoint = "api/v1/tasks";
    var url = Uri.parse(BASE_URL + endpoint);

    await http.post(url, body: task.toBody());
  }

  static void updateTask(Task task) async {
    String endpoint = "api/v1/tasks";
    var url = Uri.parse(BASE_URL + endpoint);

    await http.patch(url, body: task.toBodyUpdate());
  }
}
