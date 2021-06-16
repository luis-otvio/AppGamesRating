import 'package:app_games_rating/app/modules/jogos/model/jogo_model.dart';
import 'package:app_games_rating/app/modules/jogos/page/listing/jogos_store.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class JogosPage extends StatefulWidget {
  @override
  JogosPageState createState() => JogosPageState();
}

class JogosPageState extends State<JogosPage> {
  final jogosController = JogosStore();

  TextEditingController _pesquisaController = TextEditingController();

  String filtro = "";

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
          "Jogos",
          style: TextStyle(color: Colors.red[700]),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(
          children: [
            Material(
              elevation: 2,
              child: SizedBox(
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _pesquisaController,
                        decoration: InputDecoration(
                          hintText: 'Pesquise um jogo...',
                          fillColor: Colors.white,
                          filled: true,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: IconButton(
                        color: Colors.red[700],
                        icon: Icon(Icons.search),
                        onPressed: () async {
                          filtro = _pesquisaController.text;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: FutureBuilder(
                  future: filtro != "" ? jogosController.getJogos(filtro: filtro) : jogosController.getJogos(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      var error = snapshot.error;

                      CoolAlert.show(
                        context: context,
                        type: CoolAlertType.error,
                        barrierDismissible: false,
                        title: "Ops!",
                        text: error.toString(),
                        onConfirmBtnTap: () {
                          Modular.to.pushReplacementNamed('/');
                        },
                      );
                    }

                    if (jogosController.jogos.length > 0) {
                      return ListView.builder(
                        itemCount: jogosController.jogos.length,
                        itemBuilder: (context, index) {
                          Jogo jogo = jogosController.jogos[index];

                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(backgroundImage: NetworkImage(jogo.urlImage)),
                            title: Text(jogo.title),
                            subtitle: Text(
                              jogo.producer,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onTap: () => Modular.to.pushNamed('/jogos/details', arguments: jogo),
                          );
                        },
                      );
                    } else {
                      return Container(
                        child: Center(
                          child: Text("Nenhum jogo encontrado."),
                        ),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
