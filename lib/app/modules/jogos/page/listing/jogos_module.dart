import 'package:app_games_rating/app/modules/jogos/page/listing/jogos_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class JogosModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => JogosPage()),
  ];
}
