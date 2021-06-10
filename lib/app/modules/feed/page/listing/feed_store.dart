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
  // ignore: missing_return
  Future<List<Feed>> getFeed(String authToken, {dynamic idUser}) async {
    if (idUser != null) {
      return await feedRepository.getFeed(authToken, idUser: idUser);
    } else {
      feed = await feedRepository.getFeed(authToken);
    }
  }

  Future<void> likeDislikeFeed(int likeType, dynamic idUser, int idEvaluation, String authToken) async {
    await feedRepository.likeDislikeFeed(likeType, idUser, idEvaluation, authToken);
  }
}
