import 'package:flutter/material.dart';

Drawer myDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Image.asset(
            "assets/images/logo.png",
            width: MediaQuery.of(context).size.width / 2,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
        ),
        ListTile(
          leading: Icon(Icons.gamepad_outlined),
          title: Text('Jogos'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.bar_chart),
          title: Text('Ranking'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Sair'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
