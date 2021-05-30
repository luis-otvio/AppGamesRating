import 'package:app_games_rating/app/modules/feed/page/register/feed_register_store.dart';
import 'package:app_games_rating/app/modules/jogos/model/jogo_model.dart';
import 'package:app_games_rating/app/modules/jogos/page/jogos_store.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FeedRegisterPage extends StatefulWidget {
  @override
  FeedRegisterPageState createState() => FeedRegisterPageState();
}

class FeedRegisterPageState extends State<FeedRegisterPage> {
  final feedRegisterController = FeedRegisterStore();
  final jogosController = JogosStore();

  final _formKey = GlobalKey<FormState>();
  final avalicaoController = TextEditingController();

  int jogoSelecionado = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.red[700]),
        title: Text(
          "Nova Avaliação",
          style: TextStyle(color: Colors.red[700]),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Preencha os campos abaixo para inserir uma nova avaliação para o game desejado:"),
                SizedBox(height: 20),
                Text("Qual jogo você quer avaliar?", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15)),
                SizedBox(height: 10),
                Material(
                  elevation: 2,
                  child: DropdownSearch<Jogo>(
                    mode: Mode.BOTTOM_SHEET,
                    maxHeight: 700,
                    loadingBuilder: (context, texto) => Center(
                      child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    ),
                    hint: "Selecione um jogo",
                    isFilteredOnline: true,
                    showSearchBox: true,
                    searchBoxDecoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Pesquise...",
                    ),
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validator: (u) => u == null ? "É necessário informar o jogo a ser avaliado. " : null,
                    onFind: (String filter) => jogosController.getJogos(filter: filter, retornarLista: true),
                    dropdownSearchDecoration: InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    ),
                    onChanged: (data) {
                      jogoSelecionado = data.id;
                    },
                    dropdownBuilder: _customDropDown,
                    popupItemBuilder: _customPopupItemBuilder,
                    popupSafeArea: PopupSafeArea(top: true, bottom: true),
                  ),
                ),
                SizedBox(height: 20),
                Text("Informe a sua opinião:", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15)),
                SizedBox(height: 10),
                Material(
                  elevation: 2,
                  child: TextFormField(
                    controller: avalicaoController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "O que você acha desse jogo? Conte para nós.",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Para avaliar, é preciso informar a sua opinião.';
                      }
                      return null;
                    },
                    maxLines: 6,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: TextButton(
          child: Text('Publicar'),
          style: TextButton.styleFrom(
            backgroundColor: Colors.red[400],
            primary: Colors.white,
            textStyle: TextStyle(color: Colors.white, fontSize: 15),
          ),
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();

              CoolAlert.show(
                context: context,
                type: CoolAlertType.loading,
                text: "Carregando...",
                barrierDismissible: false,
              );

              await feedRegisterController.publicarAvalicao(avalicaoController.text, jogoSelecionado, 6).then((value) {
                Modular.to.pop();
                CoolAlert.show(
                  context: context,
                  type: CoolAlertType.success,
                  barrierDismissible: false,
                  title: "Sucesso!",
                  text: "Avaliação cadastrada com sucesso!",
                  onConfirmBtnTap: () {
                    Modular.to.pushReplacementNamed('/');
                  },
                );
              }).onError((error, stackTrace) {
                Modular.to.pop();
                CoolAlert.show(
                  context: context,
                  type: CoolAlertType.info,
                  barrierDismissible: false,
                  title: "Ops!",
                  text: error.toString(),
                  onConfirmBtnTap: () {
                    Modular.to.pop();
                  },
                );
              });
            }
          },
        ),
      ),
    );
  }

  Widget _customDropDown(BuildContext context, Jogo jogo, String itemDesignation) {
    if (jogo == null) {
      return Container();
    }

    return Container(
      child: (jogo.urlImage == null)
          ? ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: CircleAvatar(),
              title: Text("Nenhum jogo selecionado"),
            )
          : ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: CircleAvatar(backgroundImage: NetworkImage(jogo.urlImage)),
              title: Text(jogo.title),
              subtitle: Text(jogo.producer),
            ),
    );
  }

  Widget _customPopupItemBuilder(BuildContext context, Jogo jogo, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(jogo.title),
        subtitle: Text(jogo.producer),
        leading: CircleAvatar(backgroundImage: NetworkImage(jogo.urlImage)),
      ),
    );
  }
}
