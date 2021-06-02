import 'package:app_games_rating/app/modules/jogos/page/jogos_module.dart';
import 'package:app_games_rating/app/modules/jogos/page/jogos_store.dart';
import 'package:app_games_rating/app/modules/jogos/repository/jogos_repository.dart';
import 'package:app_games_rating/app/modules/feed/page/details/feed_details_module.dart';
import 'package:app_games_rating/app/modules/feed/page/register/feed_register_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_store.dart';
import 'modules/feed/page/listing/feed_store.dart';
import 'modules/feed/page/listing/feed_module.dart';
import 'modules/feed/repository/feed_repository.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => JogosStore()),
    Bind.lazySingleton((i) => JogosRepository()),
    Bind.lazySingleton((i) => AppStore()),
    Bind.lazySingleton((i) => FeedStore()),
    Bind.lazySingleton((i) => FeedRepository()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: FeedModule()),
    ModuleRoute('/feed/details', module: FeedDetailsModule()),
    ModuleRoute('/feed/register', module: FeedRegisterModule()),
    ModuleRoute('/jogos', module: JogosModule()),
  ];
}
