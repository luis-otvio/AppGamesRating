import 'package:app_games_rating/app/modules/login/helper/usuario_helper.dart';
import 'package:app_games_rating/app/modules/login/model/usuario_model.dart';
import 'package:mobx/mobx.dart';

part 'loading_store.g.dart';

class LoadingStore = _LoadingStoreBase with _$LoadingStore;

abstract class _LoadingStoreBase with Store {
  UsuarioHelper _db = UsuarioHelper();

  Future<List<Usuario>> verificarUsuarioLogado() async {
    return await _db.getUsuario();
  }
}
