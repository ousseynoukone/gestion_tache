import 'package:gestion_tache/interfaces/Default/models/task.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpTask {
  static const String BASE_URL = "http://10.0.2.2:5050/";

  static Future<List<Task>> fetchTasksByUser(userID) async {
    String endpoint = "api/v1/tasks/$userID";
    List<Task> tasks = [];
    final response = await http.get(Uri.parse(BASE_URL + endpoint));

    List jsonParsed = jsonDecode(response.body);
    for (int i = 0; i < jsonParsed.length; i++) {
      //print(jsonParsed[i]);
      tasks.add(Task.fromJson(jsonParsed[i]));
    }
    return tasks;
  }

  static Future<List<Task>> fetchTasks() async {
    String endpoint = "api/v1/tasks/";
    List<Task> tasks = [];
    final response = await http.get(Uri.parse(BASE_URL + endpoint));

    List jsonParsed = jsonDecode(response.body);
    for (int i = 0; i < jsonParsed.length; i++) {
      //print(jsonParsed[i]);
      tasks.add(Task.fromJson(jsonParsed[i]));
    }
    return tasks;
  }

  static Future<List<int>> fetchTasksNumberByUser(id) async {
    String endpoint1 = "api/v1/tasks/numbers/$id";
    List<int> realNumber = [];
    final response1 = await http.get(Uri.parse(BASE_URL + endpoint1));
    var number = json.decode(response1.body);
    if (number['allNumber'][0] != null &&
        number['allNumber'][1] != null &&
        number['allNumber'][2] != null &&
        number['allNumber'][3] != null) {
      realNumber.add(number['allNumber'][0]);
      realNumber.add(number['allNumber'][1]);
      realNumber.add(number['allNumber'][2]);
      realNumber.add(number['allNumber'][3]);
    }
    print(realNumber);
    return realNumber;
  }

  static Future<List<int>> fetchTasksNumbers() async {
    String endpoint1 = "api/v1/tasks/public/task/numbers/";
    List<int> realNumber = [];
    final response1 = await http.get(Uri.parse(BASE_URL + endpoint1));
    var number = json.decode(response1.body);
    print(number);
    if (number['allNumber'][0] != null &&
        number['allNumber'][1] != null &&
        number['allNumber'][2] != null &&
        number['allNumber'][3] != null) {
      realNumber.add(number['allNumber'][0]);
      realNumber.add(number['allNumber'][1]);
      realNumber.add(number['allNumber'][2]);
      realNumber.add(number['allNumber'][3]);
    }
    print("Public task fetch from Task fetcher frealNumber $realNumber");
    return realNumber;
  }

  static Future<http.Response> deleteTask(id) async {
    String endpoint = "api/v1/taskDelete/$id";

    return await http.delete(
      Uri.parse(BASE_URL + endpoint),
    );
  }

  static Future<http.Response> addTask(Task task) async {
    String endpoint = "api/v1/tasks";
    var url = Uri.parse(BASE_URL + endpoint);

    return await http.post(url, body: task.toBody());
  }

  static Future<http.Response> updateTask(Task task) async {
    String endpoint = "api/v1/tasks";
    var url = Uri.parse(BASE_URL + endpoint);

    return await http.patch(url, body: task.toBodyUpdate());
  }
}
