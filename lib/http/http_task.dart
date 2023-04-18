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
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // tasks.add(Task.fromJson(jsonDecode(response.body)));
    return tasks;
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
}
