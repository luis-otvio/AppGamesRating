import 'package:app_games_rating/app/modules/jogos/model/jogo_model.dart';
import 'package:app_games_rating/app/modules/jogos/repository/jogos_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'jogos_store.g.dart';

class JogosStore = _JogosStoreBase with _$JogosStore;

abstract class _JogosStoreBase with Store {
  final jogosRepository = Modular.get<JogosRepository>();

  @observable
  List<Jogo> jogos = <Jogo>[];

  @action
  Future<List<Jogo>> getJogos({String filter, bool retornarLista = false}) async {
    if (retornarLista) {
      return await jogosRepository.getJogos(filter: filter);
    } else {
      jogos = await jogosRepository.getJogos(filter: filter);
    }
  }
}
