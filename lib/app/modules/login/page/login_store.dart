import 'package:app_games_rating/app/modules/login/repository/login_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  final loginRepository = Modular.get<LoginRepository>();

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

  // @action
  // Future<UserCredential> loginWithFacebook() async {
  //   return await loginRepository.loginWithFacebook();
  // }
}
