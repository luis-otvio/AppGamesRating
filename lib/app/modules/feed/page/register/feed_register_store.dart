import 'package:app_games_rating/app/modules/feed/repository/feed_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'feed_register_store.g.dart';

class FeedRegisterStore = _FeedRegisterStoreBase with _$FeedRegisterStore;

abstract class _FeedRegisterStoreBase with Store {
  final feedRegisterRepository = Modular.get<FeedRepository>();

  Future publicarAvalicao(String review, int idGame, int idUser) async {
    try {
      await feedRegisterRepository.insertFeed(review, idGame, idUser);
    } catch (e) {
      throw e.toString();
    }
  }
}
