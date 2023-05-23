import 'package:firebase_auth/firebase_auth.dart';
import 'package:Groupe_8/globals/globals.dart' as globals;
import 'package:Groupe_8/interfaces/auth/sharedPreference.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/services.dart';

import 'package:Groupe_8/globals/globals.dart' as globals;
import 'package:Groupe_8/interfaces/auth/sharedPreference.dart';

class AuthCheckAndCreate {
  static Future<String?> userLogIn(String mail, String pwd) async {
    FirebaseAuth.instance.setLanguageCode('fr');
    // sharedPreference.removeUserCredential();
    try {
      final result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: mail, password: pwd);
      print(result.user?.email);
      var u = result.user;

      print(u!.emailVerified);
      if (u!.emailVerified == false) {
        return "false";
      }

      globals.user = result.user;
      Map<String, dynamic> user = {
        'email': result.user?.email,
        'password': pwd,
        'username': result.user?.displayName
      };
      var isExist = await sharedPreference.isUserExist();

      if (isExist == false) {
        await sharedPreference.saveUserCredential(user);
      } else {
        print("user already exist ! ");
      }
      return null;
    } on FirebaseAuthException catch (ex) {
      return "${ex.code}: ${ex.message}";
    }
  }

  static Future<String?> userGoogleLogIn(
      String accessToken, String idToken) async {
    FirebaseAuth.instance.setLanguageCode('fr');

    try {
      final credential = GoogleAuthProvider.credential(
          accessToken: accessToken, idToken: idToken);
      var user = await FirebaseAuth.instance.signInWithCredential(credential);
      var userInformation = user.additionalUserInfo!.profile;
      globals.name = userInformation!['name'];
      return null;
    } on FirebaseAuthException catch (ex) {
      return "${ex.code}: ${ex.message}";
    }
  }

  static Future<String?> createUserAccount(
      String mail, String pwd, String name) async {
    FirebaseAuth.instance.setLanguageCode('fr');

    try {
      var result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: mail.trim(), password: pwd.trim());
      var u = result.user;
      u?.updateDisplayName(name);
      u!.sendEmailVerification(); //Pour envoyer un email de verification

      return null;
    } on FirebaseAuthException catch (ex) {
      return "${ex.code}: ${ex.message}";
    }
  }

  static Future<bool> resetPassword({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (ex) {
      print(ex.message);
      return false;
    }
  }

  static Future<bool> googleLogIn() async {
    try {
      final GoogleSignInAccount? signInUser = await GoogleSignIn().signIn();
      if (signInUser != null) {
        final GoogleSignInAuthentication? authUser =
            await signInUser.authentication;
        if (authUser != null) {
          final credential = GoogleAuthProvider.credential(
            accessToken: authUser.accessToken,
            idToken: authUser.idToken,
          );

          var user =
              await FirebaseAuth.instance.signInWithCredential(credential);
          var userInformation = user.additionalUserInfo?.profile;
          globals.name = userInformation?['name'];

          Map<String, dynamic> data = {
            'accessToken': authUser.accessToken,
            'idToken': authUser.idToken,
          };

          var isExist = await sharedPreference.isUserExist();

          if (isExist == false) {
            await sharedPreference.saveUserCredentialGoogle(data);
          } else {
            print("user already exists!");
          }

          return true;
        }
      }
    } on PlatformException catch (ex) {
      if (ex.code == 'sign_in_canceled') {
        print('Sign-in canceled by the user');
      } else {
        print('Error during Google sign-in: ${ex.message}');
      }
    } catch (ex) {
      print('Error during Google sign-in: $ex');
    }

    return false;
  }

  static Future<bool> facebookLogIn() async {
    try {
      return true;
    } catch (ex) {
      print(ex);
    }
    return false;
  }
}
