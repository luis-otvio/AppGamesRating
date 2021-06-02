// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jogos_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$JogosStore on _JogosStoreBase, Store {
  final _$jogosAtom = Atom(name: '_JogosStoreBase.jogos');

  @override
  List<Jogo> get jogos {
    _$jogosAtom.reportRead();
    return super.jogos;
  }

  @override
  set jogos(List<Jogo> value) {
    _$jogosAtom.reportWrite(value, super.jogos, () {
      super.jogos = value;
    });
  }

  final _$getJogosAsyncAction = AsyncAction('_JogosStoreBase.getJogos');

  @override
  Future<List<Jogo>> getJogos({String filtro, bool retornarLista = false}) {
    return _$getJogosAsyncAction.run(
        () => super.getJogos(filtro: filtro, retornarLista: retornarLista));
  }

  @override
  String toString() {
    return '''
jogos: ${jogos}
    ''';
  }
}
