import 'package:app_games_rating/app/app_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PerfilPage extends StatefulWidget {
  @override
  PerfilPageState createState() => PerfilPageState();
}

class PerfilPageState extends State<PerfilPage> {
  final appController = Modular.get<AppStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.red[700]),
        title: Text(
          "Perfil de Usuário",
          style: TextStyle(color: Colors.red[700]),
        ),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
