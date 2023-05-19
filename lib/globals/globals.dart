library gestion_tache.globals;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:gestion_tache/interfaces/Default/models/task.dart';

String username = "";
String name = "";
String password = "";
User ? user ;
String? errorMessage;
String? successMessage;
int? number = 0;
Task? task;

Future<List<Task>>? tasks;
