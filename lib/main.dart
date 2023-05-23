import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:Groupe_8/interfaces/Default/accueil.dart';
import 'firebase_options.dart';
import 'interfaces/auth/start.dart';

import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:Groupe_8/model_theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


//firebaseMessagingBackgroundHansler est une fonction qui est appelée 
//lorsque ton application reçoit une notification en arrière-plan 
Future<void> _firebaseMessagingBackgroundHansler(RemoteMessage message) async{
  await Firebase.initializeApp();
  print("Gestion d'un message en arrière plan with id ${message.messageId}");
}

//firebaseMessagingForegroundHandler est une fonction qui est appelée lorsque 
//ton application reçoit une notification alors qu'elle est en cours d'exécution en premier plan
void _firebaseMessagingForegroundHandler(RemoteMessage message) {
  print('J ai reçu un message alors qu il était au premier plan!');
  print('Message data: ${message.data}');

  if (message.notification != null) {
    print('Le message contenait également une notification: ${message.notification}');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // add this line

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHansler);
  await Firebase.initializeApp(
    name: 'task-app',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //FirebaseMessaging.onMessage.listen(_firebaseMessagingForegroundHandler); 
  //configure l'écoute des messages entrants lorsque l'application est en premier plan
  
  FirebaseMessaging.onMessage.listen( _firebaseMessagingForegroundHandler);
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print('token: $fcmToken');

  //récupère le jeton FCM pour l'appareil en cours d'utilisation. 
  //Le jeton est ensuite stocké dans la variable fcmToken
  FirebaseMessaging.instance.onTokenRefresh
  .listen((fcmToken) {})
  .onError((err) {});
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ModelTheme(),
        child: Consumer<ModelTheme>(
            builder: (context, ModelTheme themeNotifier, child) {
            return FutureBuilder<SharedPreferences>(
              future: SharedPreferences.getInstance(),
              builder: (BuildContext context,
                  AsyncSnapshot<SharedPreferences> snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                final sharedPreferences = snapshot.data!;
                final isDarkMode = sharedPreferences.getBool('isDarkMode') ?? false;

                  return MaterialApp(
                  localizationsDelegates: [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: [
                    const Locale('fr'),

                  ],
                  locale: const Locale('fr'),
                  debugShowCheckedModeBanner: false,

                  title: 'Gestionnaire de tache',

                  // theme: ThemeData(
                  //   primaryColor: const Color.fromARGB(255, 68, 21, 151),
                  //   secondaryHeaderColor: Colors.white,
                  //   primaryColorDark: Colors.redAccent,
                  // ),
                    // theme: themeNotifier.isDark
                    //   ? ThemeData(
                    //       brightness: Brightness.dark,
                    //     )
                    //   : ThemeData(
                    //       brightness: Brightness.light,
                    //       primaryColor: const Color.fromARGB(255, 68, 21, 151),
                    //       primaryColorDark: Colors.redAccent,
                    //     ),
                  // themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
                  themeMode: ThemeMode.system,
                  theme: themeNotifier.isDark
                    ? ThemeData(
                        brightness: Brightness.dark,
                      )
                    : ThemeData(
                        brightness: Brightness.light,
                        primaryColor: const Color.fromARGB(255, 68, 21, 151),
                        primaryColorDark: Colors.redAccent,
                      ),
                    darkTheme: ThemeData.dark(),
                  //home: const Home(),
                  home: const Start(),
                );
              }
              );

          
        }));
  }
}
