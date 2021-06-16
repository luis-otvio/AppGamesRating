import 'package:app_games_rating/app/modules/feed/page/edit/feed_edit_module.dart';
import 'package:app_games_rating/app/modules/jogos/page/details/jogos_details_module.dart';
import 'package:app_games_rating/app/modules/login/page/login_store.dart';
import 'package:app_games_rating/app/modules/perfil/page/perfil_module.dart';
import 'package:app_games_rating/app/modules/usuario/repository/usuario_repository.dart';
import 'package:app_games_rating/app/modules/usuario/page/usuario_store.dart';
import 'package:app_games_rating/app/modules/login/repository/login_repository.dart';
import 'package:app_games_rating/app/modules/jogos/page/listing/jogos_module.dart';
import 'package:app_games_rating/app/modules/jogos/page/listing/jogos_store.dart';
import 'package:app_games_rating/app/modules/jogos/repository/jogos_repository.dart';
import 'package:app_games_rating/app/modules/feed/page/details/feed_details_module.dart';
import 'package:app_games_rating/app/modules/feed/page/register/feed_register_module.dart';
import 'package:app_games_rating/app/modules/login/page/criar_conta/page/criar_conta_module.dart';
import 'package:app_games_rating/app/modules/login/page/login_module.dart';
import 'package:app_games_rating/app/modules/login/page/recuperar_senha/page/recuperar_senha_module.dart';
import 'package:app_games_rating/app/modules/usuario/helper/usuario_helper.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_store.dart';
import 'modules/feed/page/feed_store.dart';
import 'modules/feed/page/listing/feed_module.dart';
import 'modules/feed/repository/feed_repository.dart';
import 'modules/loading/page/loading_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => UsuarioRepository()),
    Bind.lazySingleton((i) => UsuarioStore()),
    Bind.lazySingleton((i) => UsuarioHelper()),
    Bind.lazySingleton((i) => LoginStore()),
    Bind.lazySingleton((i) => LoginRepository()),
    Bind.lazySingleton((i) => JogosStore()),
    Bind.lazySingleton((i) => JogosRepository()),
    Bind.lazySingleton((i) => AppStore()),
    Bind.lazySingleton((i) => FeedStore()),
    Bind.lazySingleton((i) => FeedRepository()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: LoadingModule()),
    ModuleRoute('/login', module: LoginModule()),
    ModuleRoute('/login/register', module: CriarContaModule()),
    ModuleRoute('/login/recoveryPassword', module: RecuperarSenhaModule()),
    ModuleRoute('/feed', module: FeedModule()),
    ModuleRoute('/feed/details', module: FeedDetailsModule()),
    ModuleRoute('/feed/register', module: FeedRegisterModule()),
    ModuleRoute('/feed/edit', module: FeedEditModule()),
    ModuleRoute('/jogos', module: JogosModule()),
    ModuleRoute('/jogos/details', module: JogosDetailsModule()),
    ModuleRoute('/profile', module: PerfilModule()),
  ];
}
