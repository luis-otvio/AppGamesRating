import 'package:app_games_rating/app/modules/feed/model/feed_model.dart';
import 'package:app_games_rating/app/modules/feed/model/like_by_user.dart';
import 'package:app_games_rating/app/modules/feed/repository/feed_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'feed_store.g.dart';

class FeedStore = _FeedStoreBase with _$FeedStore;

abstract class _FeedStoreBase with Store {
  final feedRepository = Modular.get<FeedRepository>();

  @observable
  List<Feed> feed = <Feed>[];

  @observable
  List<LikeByUser> likedDislikedPosts = <LikeByUser>[];

  @action
  // ignore: missing_return
  Future<List<Feed>> getFeed(String authToken, dynamic idUser, bool feedByUser) async {
    if (feedByUser) {
      // busca posts por usuário
      await getLikeDislikeByUser(idUser, authToken);
      return await feedRepository.getFeed(authToken, idUser: idUser);
    } else {
      feed = await feedRepository.getFeed(authToken);
      await getLikeDislikeByUser(idUser, authToken);
    }
  }

  @action
  Future getLikeDislikeByUser(int idUser, String authToken) async {
    likedDislikedPosts = await feedRepository.getLikesFromUser(idUser, authToken);
  }

  Future<void> likeDislikeFeed(int likeType, dynamic idUser, int idEvaluation, String authToken) async {
    await feedRepository.likeDislikeFeed(likeType, idUser, idEvaluation, authToken);
  }
}
