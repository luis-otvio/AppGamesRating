import 'package:app_games_rating/app/modules/usuario/model/usuario_model.dart';
import 'package:app_games_rating/app/modules/usuario/repository/usuario_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'usuario_store.g.dart';

class UsuarioStore = _UsuarioStoreBase with _$UsuarioStore;

abstract class _UsuarioStoreBase with Store {
  final usuarioRepository = Modular.get<UsuarioRepository>();

  Future<bool> verificarUsuarioCadastrado(String email) async {
    return await usuarioRepository.isUsuarioCadastrado(email);
  }

  Future<void> inserirUsuario(Usuario usuario, String senha) async {
    await usuarioRepository.insertUsuario(usuario, senha);
  }
}
