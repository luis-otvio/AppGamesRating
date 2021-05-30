import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Games Rating',
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: Colors.red[300],
        accentColor: Colors.red,
      ),
    ).modular();
  }
}
