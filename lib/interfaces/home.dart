import 'package:flutter/material.dart';

import 'auth/auth.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> _interfaces = [];
  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _interfaces.add(Auth(onNext: (index) {
      setState(() {
        print('index fourni from auth ${index}');
        _currentIndex = index;
      });
    }));

    /*
    _interfaces.add(PwdScreen(onNext: (index) {
      setState(() {
        print('index fourni from pwd ${index}');
        _currentIndex = index;
      });
    }));

    _interfaces.add(CguScreen(onNext: (index) {
      setState(() {
        print('index fourni from cgu ${index}');
        _currentIndex = index;
      });

    }));*/
    
    }

    @override
    Widget build(BuildContext context) {
      return Container(
        child: _interfaces.elementAt(_currentIndex),
      );
    }
  
}
