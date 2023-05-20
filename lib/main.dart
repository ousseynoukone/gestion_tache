import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:Groupe_8/interfaces/Default/accueil.dart';
import 'firebase_options.dart';
import 'interfaces/auth/start.dart';

import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:Groupe_8/model_theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // add this line
  await Firebase.initializeApp(
    name: 'task-app',
    options: DefaultFirebaseOptions.currentPlatform,
  );
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

                  themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
                  // theme: ThemeData.light().copyWith(
                  // primaryColor: const Color.fromARGB(255, 68, 21, 151),
                  // primaryColorDark: Colors.redAccent,
                  // ),
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
