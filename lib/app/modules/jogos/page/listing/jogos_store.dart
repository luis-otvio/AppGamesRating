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
  // ignore: missing_return
  Future<List<Jogo>> getJogos({String filtro, bool retornarLista = false}) async {
    if (retornarLista) {
      // necessário para o plugin de combobox retornar o List
      if (filtro != null && filtro != "") {
        return await jogosRepository.getJogos(filtro: filtro);
      } else {
        return await jogosRepository.getJogos();
      }
    } else {
      if (filtro != null) {
        jogos = await jogosRepository.getJogos(filtro: filtro);
      } else {
        jogos = await jogosRepository.getJogos();
      }
    }
  }
}
