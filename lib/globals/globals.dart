library gestion_tache.globals;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:Groupe_8/interfaces/Default/models/task.dart';

String username = "";
String password = "";
User ? user ;
String? errorMessage;
String? successMessage;
int? number = 0;
Task? task;

Future<List<Task>>? tasks;
