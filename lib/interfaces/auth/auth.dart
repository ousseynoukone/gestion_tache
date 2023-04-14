import 'package:flutter/material.dart';



class Auth extends StatefulWidget {
    final Function(int) onNext;
  const Auth({super.key ,  required this.onNext});

  @override
  State<Auth> createState() => _AuthState();
}


class _AuthState extends State<Auth> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}