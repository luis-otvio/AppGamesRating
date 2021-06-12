import 'package:app_games_rating/app/modules/feed/page/edit/feed_edit_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FeedEditModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => FeedEditPage(args.data)),
  ];
}
