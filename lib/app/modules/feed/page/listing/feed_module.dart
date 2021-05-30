import 'package:app_games_rating/app/modules/feed/page/listing/feed_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FeedModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => FeedPage()),
  ];
}
