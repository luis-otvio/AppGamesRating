import 'dart:convert';

import 'package:app_games_rating/app/app_store.dart';
import 'package:app_games_rating/app/modules/feed/model/feed_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;

class FeedRepository {
  final appController = Modular.get<AppStore>();

  Future<List<Feed>> getFeed(String authToken) async {
    try {
      String url = appController.getUrlBase() + "/feed";

      var resultado = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Authorization': authToken,
        },
      );

      if (resultado.statusCode != 200) {
        throw Exception("Erro " + resultado.statusCode.toString() + " ao buscar feed.");
      } else {
        var feed = <Feed>[];

        var feedJson = json.decode(utf8.decode(resultado.bodyBytes));
        for (var fJson in feedJson['content']) {
          feed.add(Feed.fromJson(fJson));
        }

        return feed;
      }
    } catch (e) {
      throw Exception("Não foi possível comunicar com o servidor. " + e.toString());
    }
  }

  Future insertFeed(String review, int idGame, int idUser, String authToken) async {
    try {
      String url = appController.getUrlBase() + "/evaluation";

      var resultado = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': authToken,
        },
        body: jsonEncode(
          <String, String>{
            "review": review,
            "game": idGame.toString(),
            "user": idUser.toString(),
          },
        ),
      );

      if (resultado.statusCode != 200 && resultado.statusCode != 201) {
        throw json.decode(utf8.decode(resultado.bodyBytes))['erro'];
      }
    } catch (e) {
      throw e;
    }
  }
}
