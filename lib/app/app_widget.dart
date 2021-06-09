import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Games Rating',
      localizationsDelegates: [GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate],
      supportedLocales: [const Locale('pt', 'BR')],
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: Colors.red[300],
        accentColor: Colors.red,
      ),
    ).modular();
  }
}
