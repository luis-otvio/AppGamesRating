import 'dart:convert';

import 'package:app_games_rating/app/app_store.dart';
import 'package:app_games_rating/app/modules/jogos/model/jogo_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:http/http.dart' as http;

class JogosRepository {
  final appController = Modular.get<AppStore>();

  Future<List<Jogo>> getJogos({String filtro}) async {
    try {
      String url = appController.getUrlBase();
      if (filtro != null && filtro != "") {
        url += "/game/filter/game";
      } else {
        url += "/game?sort=title,ASC";
      }

      var resultado;

      if (filtro != null && filtro != "") {
        resultado = await http.post(
          Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            <String, String>{
              "title": filtro,
            },
          ),
        );
      } else {
        resultado = await http.get(Uri.parse(url));
      }

      if (resultado.statusCode != 200) {
        throw Exception("Erro " + resultado.statusCode.toString() + " ao buscar jogos.");
      } else {
        var jogos = <Jogo>[];

        var feedJson = json.decode(utf8.decode(resultado.bodyBytes));
        for (var fJson in feedJson['content']) {
          jogos.add(Jogo.fromJson(fJson));
        }

        return jogos;
      }
    } catch (e) {
      throw Exception("Não foi possível comunicar com o servidor. " + e.toString());
    }
  }
}
