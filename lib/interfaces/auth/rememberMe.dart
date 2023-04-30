import 'dart:convert';

import 'package:path_provider/path_provider.dart';
import 'dart:io';

class rememberMe {
  static Future<File> writeAuthCredential(Map<String, dynamic> data) async {
    final Directory directory = await getApplicationDocumentsDirectory();

    final path = directory.path;
    final file = File('$path/auth_credential.txt');

    if (!await file.exists()) {
      String jsonData = json.encode(data);
      return file.writeAsString(jsonData);
    }
    return file;
  }

  static Future<Map<String, dynamic>> readAuthCredential() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final file = File('$path/auth_credential.txt');

    if (await file.exists()) {
      String jsonData = await file.readAsString();
      Map<String, dynamic> data = json.decode(jsonData);
      return data;
    } else {
      return {};
    }
  }


static void logOut() async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final path = directory.path;
  final file = File('$path/auth_credential.txt');

  try {
    if (await file.exists()) {
      await file.delete();
      print('File deleted successfully');
    } else {
      print('File not found');
    }
  } catch (e) {
    print('Failed to delete file. Error: $e');
  }
}

}
