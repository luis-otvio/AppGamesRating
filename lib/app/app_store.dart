import 'package:app_games_rating/app/modules/usuario/model/usuario_model.dart';
import 'package:mobx/mobx.dart';

part 'app_store.g.dart';

class AppStore = _AppStoreBase with _$AppStore;

abstract class _AppStoreBase with Store {
  @observable
  Usuario usuarioLogado = Usuario();

  @action
  setUsuarioLogado(Usuario value) {
    usuarioLogado = value;
  }

  final String urlDev = "https://games-rating-api-dev.herokuapp.com";
  final String urlProd = "https://games-rating-api-prod.herokuapp.com";

  String devMode = "dev";

  String getUrlBase() {
    return devMode == "dev" ? urlDev : urlProd;
  }
}
