import 'dart:io';

import 'package:app_games_rating/app/modules/login/model/usuario_model.dart';
import 'dart:async';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class UsuarioHelper {
  String nomeTabela = "usuario";
  String colId = 'id';
  String colName = 'name';
  String colNickName = 'nickname';
  String colEmail = 'email';
  String colUrlImage = 'urlImage';
  String colBirthDate = 'birthDate';
  String colDateCreated = 'dateCreated';
  String colTokenAcesso = 'accessToken';

  static UsuarioHelper _databaseHelper;
  static Database _database;

  UsuarioHelper._createInstance();

  factory UsuarioHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = UsuarioHelper._createInstance();
    }

    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await inicializarDB();
    }

    return _database;
  }

  void _criarBanco(Database db, int versao) async {
    await db.execute(
      'CREATE TABLE $nomeTabela('
      '$colId          INTEGER PRIMARY KEY,'
      '$colName        TEXT,'
      '$colNickName    TEXT,'
      '$colEmail       TEXT,'
      '$colUrlImage    TEXT,'
      '$colBirthDate   DATE,'
      '$colDateCreated DATETIME,'
      '$colTokenAcesso TEXT)',
    );
  }

  Future<Database> inicializarDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String caminho = directory.path + 'DB_GAMESRATING.db';

    return await openDatabase(
      caminho,
      version: 1,
      onCreate: _criarBanco,
    );
  }

  Future<int> insertUsuario(Usuario usuario) async {
    Database db = await this.database;

    return await db.insert(nomeTabela, usuario.toJson());
  }

  Future<List<Usuario>> getUsuario() async {
    Database db = await this.database;
    String sql = "SELECT * FROM $nomeTabela";

    List usuariosRecuperados = await db.rawQuery(sql);
    List<Usuario> listaUsuarios = <Usuario>[];

    for (var item in usuariosRecuperados) {
      Usuario u = Usuario.fromJson(item);
      listaUsuarios.add(u);
    }

    return listaUsuarios;
  }

  Future<void> deleteAllUsuario() async {
    Database db = await this.database;
    await db.rawDelete("DELETE FROM $nomeTabela");
  }
}
