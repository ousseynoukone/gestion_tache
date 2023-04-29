// import 'package:flutter/material.dart';
// import 'package:gestion_tache/interfaces/auth/register.dart';

// import 'auth/auth.dart';
// import 'auth/password.dart';
// import 'auth/start.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   List<Widget> _interfaces = [];
//   int _currentIndex = 0;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     _interfaces.add(Start(onNext: (index) {
//       setState(() {
//         _currentIndex = index;
//       });
//     }));

//     _interfaces.add(Auth(onNext: (index) {
//       setState(() {
//         _currentIndex = index;
//         print("Auth");
//       });
//     }));

//     _interfaces.add(Password(onNext: (index) {
//       setState(() {
//         _currentIndex = index;
//       });
//     }));

//     _interfaces.add(Register(onNext: (index) {
//       setState(() {
//         _currentIndex = index;
//         print("Register");
//       });
//     }));

//     /*
//     _interfaces.add(PwdScreen(onNext: (index) {
//       setState(() {
//         print('index fourni from pwd ${index}');
//         _currentIndex = index;
//       });
//     }));

//     _interfaces.add(CguScreen(onNext: (index) {
//       setState(() {
//         print('index fourni from cgu ${index}');
//         _currentIndex = index;
//       });

//     }));*/
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: _interfaces.elementAt(_currentIndex),
//     );
//   }
// }
