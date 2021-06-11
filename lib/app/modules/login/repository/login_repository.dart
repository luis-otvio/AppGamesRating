import 'dart:convert';

import 'package:app_games_rating/app/app_store.dart';
import 'package:app_games_rating/app/modules/usuario/model/usuario_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class LoginRepository {
  final appController = Modular.get<AppStore>();
  final FacebookLogin facebookSignIn = new FacebookLogin();

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

      String tokenAcesso = resultado.headers['authorization'];

      if (resultado.statusCode != 200 && resultado.statusCode != 201) {
        throw json.decode(resultado.body)['message'];
      } else {
        var usuario = Usuario();
        var usuarioJson = json.decode(utf8.decode(resultado.bodyBytes));
        usuario = Usuario.fromJson(usuarioJson);
        usuario.accessToken = tokenAcesso;

        return usuario;
      }
    } catch (e) {
      throw e;
    }
  }

  Future<UserCredential> loginWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future loginWithFacebook() async {
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        final graphResponse = await http.get(Uri.parse('https://graph.facebook.com/v2.12/me?fields=id,name,email,birthday,picture&access_token=${accessToken.token}'));
        return json.decode(graphResponse.body);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('Login Cancelado');
        break;
      case FacebookLoginStatus.error:
        throw result.errorMessage;
        break;
    }
  }
}
