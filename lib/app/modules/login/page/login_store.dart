import 'package:app_games_rating/app/app_store.dart';
import 'package:app_games_rating/app/modules/login/repository/login_repository.dart';
import 'package:app_games_rating/app/modules/usuario/helper/usuario_helper.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  final appController = Modular.get<AppStore>();
  final loginRepository = Modular.get<LoginRepository>();
  UsuarioHelper _db = UsuarioHelper();

  @action
  Future login(String email, String senha) async {
    try {
      return await loginRepository.login(email, senha);
    } catch (e) {
      throw e.toString();
    }
  }

  @action
  Future<UserCredential> loginWithGoogle() async {
    return await loginRepository.loginWithGoogle();
  }

  entrar(String email, String senha, BuildContext context) async {
    await login(email, senha).then((value) async {
      await _db.deleteAllUsuario();
      int resultado = await _db.insertUsuario(value);

      if (resultado != null) {
        await appController.setUsuarioLogado(value);
        Modular.to.pushReplacementNamed('/feed');
      } else {
        Modular.to.pop();
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          barrierDismissible: false,
          title: "Ops!",
          text: "Ocorreu um erro inesperado ao tentar validar os seus dados de Login.",
          onConfirmBtnTap: () {
            Modular.to.pop();
          },
        );
      }
    }).onError((error, stackTrace) {
      Modular.to.pop();
      CoolAlert.show(
        context: context,
        type: CoolAlertType.info,
        barrierDismissible: false,
        title: "Ops!",
        text: error.toString(),
        onConfirmBtnTap: () {
          Modular.to.pop();
        },
      );
    });
  }

  // @action
  // Future<UserCredential> loginWithFacebook() async {
  //   return await loginRepository.loginWithFacebook();
  // }
}
