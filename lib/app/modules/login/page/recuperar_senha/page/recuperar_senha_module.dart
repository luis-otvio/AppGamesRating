import 'package:app_games_rating/app/modules/login/page/recuperar_senha/page/recuperar_senha_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RecuperarSenhaModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => RecuperarSenhaPage()),
  ];
}
