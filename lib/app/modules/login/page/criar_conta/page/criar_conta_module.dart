import 'package:app_games_rating/app/modules/login/page/criar_conta/page/criar_conta_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CriarContaModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => CriarContaPage()),
  ];
}
