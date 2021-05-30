import 'package:mobx/mobx.dart';

part 'app_store.g.dart';

class AppStore = _AppStoreBase with _$AppStore;

abstract class _AppStoreBase with Store {
  final String urlDev = "https://games-rating-api-dev.herokuapp.com";
  final String urlProd = "https://games-rating-api-prod.herokuapp.com";

  String devMode = "dev";

  String getUrlBase() {
    return devMode == "dev" ? urlDev : urlProd;
  }
}
