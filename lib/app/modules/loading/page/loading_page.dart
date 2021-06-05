import 'package:app_games_rating/app/app_store.dart';
import 'package:app_games_rating/app/modules/loading/page/loading_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoadingPage extends StatefulWidget {
  @override
  LoadingPageState createState() => LoadingPageState();
}

class LoadingPageState extends State<LoadingPage> {
  final appController = Modular.get<AppStore>();
  final loadingController = Modular.get<LoadingStore>();

  @override
  void initState() {
    loadingController.verificarUsuarioLogado().then((value) async {
      if (value.length > 0) {
        await appController.setUsuarioLogado(value[0]);
        Modular.to.pushReplacementNamed('/feed');
      } else {
        Modular.to.pushReplacementNamed('/login');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
