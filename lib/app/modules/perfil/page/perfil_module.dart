import 'package:app_games_rating/app/modules/perfil/page/perfil_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PerfilModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => PerfilPage()),
  ];
}
