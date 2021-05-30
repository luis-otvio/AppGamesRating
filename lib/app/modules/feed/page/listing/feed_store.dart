import 'package:app_games_rating/app/modules/feed/model/feed_model.dart';
import 'package:app_games_rating/app/modules/feed/repository/feed_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'feed_store.g.dart';

class FeedStore = _FeedStoreBase with _$FeedStore;

abstract class _FeedStoreBase with Store {
  final feedRepository = Modular.get<FeedRepository>();

  @observable
  List<Feed> feed = <Feed>[];

  @action
  Future getFeed() async {
    feed = await feedRepository.getFeed();
  }
}
