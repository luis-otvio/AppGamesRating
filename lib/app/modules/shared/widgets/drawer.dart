import 'package:app_games_rating/app/app_store.dart';
import 'package:app_games_rating/app/modules/usuario/helper/usuario_helper.dart';
import 'package:app_games_rating/app/modules/usuario/model/usuario_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

Drawer myDrawer(BuildContext context) {
  UsuarioHelper usuarioHelper = UsuarioHelper();
  final appController = Modular.get<AppStore>();

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
          onTap: () => Modular.to.pushNamed('/jogos'),
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
          onTap: () async {
            Usuario usuario = Usuario();
            try {
              await FirebaseAuth.instance.signOut();
            } catch (e) {
              print(e);
            }
            await appController.setUsuarioLogado(usuario);
            await usuarioHelper.deleteAllUsuario();
            Modular.to.pushReplacementNamed('/');
          },
        ),
      ],
    ),
  );
}
