import 'package:app_games_rating/app/modules/feed/page/details/feed_details_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FeedDetailsModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => FeedDetailsPage(args.data)),
  ];
}
