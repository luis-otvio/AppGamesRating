import 'package:app_games_rating/app/app_store.dart';
import 'package:app_games_rating/app/modules/feed/model/feed_details_model.dart';
import 'package:app_games_rating/app/modules/feed/page/feed_store.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FeedEditPage extends StatefulWidget {
  final FeedDetails feedDetails;
  FeedEditPage(this.feedDetails);

  @override
  FeedEditPageState createState() => FeedEditPageState();
}

class FeedEditPageState extends State<FeedEditPage> {
  final appController = Modular.get<AppStore>();
  final feedController = Modular.get<FeedStore>();

  final _formKey = GlobalKey<FormState>();
  final avalicaoController = TextEditingController();

  @override
  void initState() {
    avalicaoController.text = widget.feedDetails.feed.evaluationUser;
    super.initState();
  }

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
          "Editar Avaliação",
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
                Row(
                  children: [
                    Text("Jogo Avaliado: ", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15)),
                    Text(widget.feedDetails.feed.titleGame, style: TextStyle(fontSize: 15)),
                  ],
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
          child: Text('Salvar'),
          style: TextButton.styleFrom(
            backgroundColor: Colors.red[400],
            primary: Colors.white,
            textStyle: TextStyle(color: Colors.white, fontSize: 15),
          ),
          onPressed: () async => _salvarEdicao(),
        ),
      ),
    );
  }

  _salvarEdicao() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      CoolAlert.show(
        context: context,
        type: CoolAlertType.loading,
        text: "Carregando...",
        barrierDismissible: false,
      );

      await feedController
          .updateFeed(
        widget.feedDetails.feed.idEvaluation,
        appController.usuarioLogado.id,
        widget.feedDetails.feed.idGame,
        avalicaoController.text,
        appController.usuarioLogado.accessToken,
      )
          .then((value) {
        Modular.to.pop();
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          barrierDismissible: false,
          title: "Sucesso!",
          text: "Avaliação editada com sucesso!",
          onConfirmBtnTap: () {
            Modular.to.pop();
            Modular.to.pop(avalicaoController.text);
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
          onConfirmBtnTap: () => Modular.to.pop(),
        );
      });
    }
  }
}
