import 'dart:convert';

import 'package:app_games_rating/app/app_store.dart';
import 'package:app_games_rating/app/modules/login/model/usuario_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;

class LoginRepository {
  final appController = Modular.get<AppStore>();

  Future<Usuario> login(String email, String senha) async {
    try {
      String url = appController.getUrlBase() + "/login";

      var resultado = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            "email": email,
            "password": senha,
          },
        ),
      );

      if (resultado.statusCode != 200 && resultado.statusCode != 201) {
        throw json.decode(resultado.body)['message'];
      } else {
        var usuario = Usuario();

        var usuarioJson = json.decode(resultado.body);
        usuario = Usuario.fromJson(usuarioJson);

        return usuario;
      }
    } catch (e) {
      throw e;
    }
  }
}
