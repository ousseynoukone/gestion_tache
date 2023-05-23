library gestion_tache.globals;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:gestion_tache/interfaces/Default/models/task.dart';

String username = "";
String name = "";
String password = "";
User? user;
String? errorMessage;
String? successMessage;
List<int> number = [0, 0, 0, 0];
Task? task;
bool apiMode = false;
Future<List<Task>>? tasks;
Function(bool) onApiModeChanged = (_) {};
Function(bool) onApiModeChangedForTaskNumber = (_) {};

Function(bool) onApiModeChangedPublicTask = (_) {};

Function(bool) onApiModeChangedForPublicTaskNumber = (_) {};

