import 'package:firebase_auth/firebase_auth.dart';
import 'package:gestion_tache/globals/globals.dart' as globals;

class AuthCheckAndCreate {
  static Future<String?> userSignIn(String mail, String pwd) async {
    try {
      final result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: mail, password: pwd);
      print(result.user?.displayName);
      globals.user = result.user;
      return null;
    } on FirebaseAuthException catch (ex) {
      return "${ex.code}: ${ex.message}";
    }
  }

  static Future<String?> createUserAccount(String mail, String pwd) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: mail, password: pwd);
      return null;
    } on FirebaseAuthException catch (ex) {
      return "${ex.code}: ${ex.message}";
    }
  }
}
