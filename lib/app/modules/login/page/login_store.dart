import 'package:app_games_rating/app/modules/login/repository/login_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  final loginRepository = Modular.get<LoginRepository>();

  @action
  Future validarLogin(String email, String senha) async {
    try {
      await loginRepository.login(email, senha);
    } catch (e) {
      throw e.toString();
    }
  }
}
