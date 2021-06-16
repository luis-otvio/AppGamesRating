import 'package:app_games_rating/app/modules/jogos/page/details/jogos_details_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class JogosDetailsModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => JogosDetailsPage(args.data)),
  ];
}
