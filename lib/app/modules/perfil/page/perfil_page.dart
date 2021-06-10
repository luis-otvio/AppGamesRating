import 'package:app_games_rating/app/app_store.dart';
import 'package:app_games_rating/app/modules/feed/page/listing/feed_store.dart';
import 'package:app_games_rating/app/modules/shared/widgets/card_avaliacao_widget.dart';
import 'package:app_games_rating/app/modules/shared/widgets/shadow_widget.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PerfilPage extends StatefulWidget {
  @override
  PerfilPageState createState() => PerfilPageState();
}

class PerfilPageState extends State<PerfilPage> {
  final appController = Modular.get<AppStore>();
  final feedController = Modular.get<FeedStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF879B),
        elevation: 0,
        titleSpacing: 0,
        centerTitle: true,
        title: Text(
          "Perfil de Usuário",
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: <Widget>[
              _containerUsuario(),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    Text(
                      "Minhas avaliações",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      width: MediaQuery.of(context).size.width / 3,
                      child: Divider(),
                    ),
                    FutureBuilder(
                      future: feedController.getFeed(appController.usuarioLogado.accessToken, idUser: appController.usuarioLogado.id),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Container(
                            height: 200,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          var error = snapshot.error;

                          CoolAlert.show(
                            context: context,
                            type: CoolAlertType.error,
                            barrierDismissible: false,
                            title: "Ops!",
                            text: error,
                            onConfirmBtnTap: () {
                              Modular.to.pushReplacementNamed('/');
                            },
                          );
                        }

                        if (snapshot.data.length > 0) {
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return CardAvaliacaoWidget(snapshot.data[index], exibirUsuario: false, exibirLikes: false);
                            },
                          );
                        } else {
                          return Container(
                            child: Center(
                              child: Text("Nenhuma avaliação encontrada."),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _containerUsuario() {
    return Container(
      padding: EdgeInsets.only(left: 40, right: 40, bottom: 40, top: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFF879B), Color(0xFFFF5656)],
        ),
        boxShadow: <BoxShadow>[shadow()],
      ),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage("${appController.usuarioLogado.urlImage}"),
            radius: 40,
          ),
          SizedBox(height: 15),
          Text(
            appController.usuarioLogado.name,
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              appController.usuarioLogado.nickName != null ? appController.usuarioLogado.nickName : "",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
