import 'package:app_games_rating/app/modules/feed/page/register/feed_register_store.dart';
import 'package:app_games_rating/app/modules/feed/page/register/feed_register_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FeedRegisterModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => FeedRegisterStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => FeedRegisterPage()),
  ];
}
