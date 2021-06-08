import 'dart:convert';

import 'package:app_games_rating/app/app_store.dart';
import 'package:app_games_rating/app/modules/usuario/model/usuario_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:http/http.dart' as http;

class UsuarioRepository {
  final appController = Modular.get<AppStore>();

  // verifica se já existe um usuário cadastrado com esse e-mail
  Future<bool> isUsuarioCadastrado(String email) async {
    try {
      String url = appController.getUrlBase() + "/user/check/email";

      var resultado = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            "email": email,
          },
        ),
      );

      if (resultado.statusCode != 200 && resultado.statusCode != 201) {
        throw json.decode(resultado.body)['message'];
      } else {
        return json.decode(resultado.body)['registered'];
      }
    } catch (e) {
      throw e;
    }
  }

  Future insertUsuario(Usuario usuario, String senha) async {
    try {
      String url = appController.getUrlBase() + "/user";

      var resultado = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            "name": usuario.name,
            "nickName": usuario.nickName,
            "email": usuario.email,
            "password": senha,
            "birthDate": usuario.birthDate,
            "urlImage": usuario.urlImage
          },
        ),
      );

      if (resultado.statusCode != 200 && resultado.statusCode != 201) {
        throw json.decode(resultado.body)['erro'];
      }
    } catch (e) {
      throw e;
    }
  }
}
