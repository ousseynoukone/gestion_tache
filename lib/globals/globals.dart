library gestion_tache.globals;

import 'package:gestion_tache/interfaces/Default/models/task.dart';

String username = "";
String password = "";
String? errorMessage;

Task? task = null;

late Future<List<Task>> tasks ;