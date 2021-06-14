// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FeedStore on _FeedStoreBase, Store {
  final _$feedAtom = Atom(name: '_FeedStoreBase.feed');

  @override
  List<Feed> get feed {
    _$feedAtom.reportRead();
    return super.feed;
  }

  @override
  set feed(List<Feed> value) {
    _$feedAtom.reportWrite(value, super.feed, () {
      super.feed = value;
    });
  }

  final _$likedDislikedPostsAtom =
      Atom(name: '_FeedStoreBase.likedDislikedPosts');

  @override
  List<LikeByUser> get likedDislikedPosts {
    _$likedDislikedPostsAtom.reportRead();
    return super.likedDislikedPosts;
  }

  @override
  set likedDislikedPosts(List<LikeByUser> value) {
    _$likedDislikedPostsAtom.reportWrite(value, super.likedDislikedPosts, () {
      super.likedDislikedPosts = value;
    });
  }

  final _$quantidadePostsUsuarioAtom =
      Atom(name: '_FeedStoreBase.quantidadePostsUsuario');

  @override
  int get quantidadePostsUsuario {
    _$quantidadePostsUsuarioAtom.reportRead();
    return super.quantidadePostsUsuario;
  }

  @override
  set quantidadePostsUsuario(int value) {
    _$quantidadePostsUsuarioAtom
        .reportWrite(value, super.quantidadePostsUsuario, () {
      super.quantidadePostsUsuario = value;
    });
  }

  final _$getFeedAsyncAction = AsyncAction('_FeedStoreBase.getFeed');

  @override
  Future<List<Feed>> getFeed(
      String authToken, dynamic idUser, bool feedByUser) {
    return _$getFeedAsyncAction
        .run(() => super.getFeed(authToken, idUser, feedByUser));
  }

  final _$getLikeDislikeByUserAsyncAction =
      AsyncAction('_FeedStoreBase.getLikeDislikeByUser');

  @override
  Future<dynamic> getLikeDislikeByUser(int idUser, String authToken) {
    return _$getLikeDislikeByUserAsyncAction
        .run(() => super.getLikeDislikeByUser(idUser, authToken));
  }

  @override
  String toString() {
    return '''
feed: ${feed},
likedDislikedPosts: ${likedDislikedPosts},
quantidadePostsUsuario: ${quantidadePostsUsuario}
    ''';
  }
}
