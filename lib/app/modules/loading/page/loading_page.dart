import 'package:app_games_rating/app/app_store.dart';
import 'package:app_games_rating/app/modules/loading/page/loading_store.dart';
import 'package:app_games_rating/app/modules/login/page/login_store.dart';
import 'package:app_games_rating/app/modules/usuario/helper/usuario_helper.dart';
import 'package:app_games_rating/app/modules/usuario/model/usuario_model.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoadingPage extends StatefulWidget {
  @override
  LoadingPageState createState() => LoadingPageState();
}

class LoadingPageState extends State<LoadingPage> {
  final appController = Modular.get<AppStore>();
  final loadingController = Modular.get<LoadingStore>();
  final loginController = Modular.get<LoginStore>();

  UsuarioHelper usuarioHelper = UsuarioHelper();
  final FacebookLogin facebookSignIn = new FacebookLogin();

  @override
  void initState() {
    loadingController.verificarUsuarioLogado().then((value) async {
      await Firebase.initializeApp();
      if (value.length > 0) {
        // busca e valida um novo token de acesso
        await loginController.refreshToken(value[0].accessToken).then((newToken) async {
          value[0].accessToken = newToken;
          await appController.setUsuarioLogado(value[0]);
          Modular.to.pushReplacementNamed('/feed');
        }).onError((error, stackTrace) async {
          Usuario usuario = Usuario();
          try {
            await FirebaseAuth.instance.signOut();
          } catch (e) {
            print(e);
          }

          try {
            await facebookSignIn.logOut();
          } catch (e) {
            print(e);
          }

          await appController.setUsuarioLogado(usuario);
          await usuarioHelper.deleteAllUsuario();

          CoolAlert.show(
            context: context,
            type: CoolAlertType.warning,
            barrierDismissible: false,
            title: "Ops!",
            text: "Sessão expirada, por favor, realize o login novamente.",
            onConfirmBtnTap: () {
              Modular.to.pushReplacementNamed('/login');
            },
          );
        });
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
