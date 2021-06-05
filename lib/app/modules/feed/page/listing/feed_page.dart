import 'package:app_games_rating/app/app_store.dart';
import 'package:app_games_rating/app/modules/feed/model/feed_model.dart';
import 'package:app_games_rating/app/modules/feed/page/listing/feed_store.dart';
import 'package:app_games_rating/app/modules/shared/widgets/drawer.dart';
import 'package:app_games_rating/app/modules/shared/widgets/shadow_widget.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final appController = Modular.get<AppStore>();
  final feedController = Modular.get<FeedStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 0,
        title: Image.asset(
          "assets/images/logo.png",
          width: 220,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      drawer: myDrawer(context),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Modular.to.pushNamed('/feed/register'),
        icon: Icon(Icons.thumb_up),
        label: Text("Avaliar"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              _cardUsuario(),
              SizedBox(height: 20),
              Column(
                children: [
                  Text(
                    "Avaliações Recentes",
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
                    future: feedController.getFeed(appController.usuarioLogado.accessToken),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          height: 200,
                          width: double.infinity,
                          child: Center(child: CircularProgressIndicator()),
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

                      if (feedController.feed.length > 0) {
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: feedController.feed.length,
                          itemBuilder: (context, index) {
                            return _cardAvaliacao(feedController.feed[index]);
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardUsuario() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFF879B), Color(0xFFFF5656)],
        ),
        boxShadow: <BoxShadow>[shadow()],
        borderRadius: BorderRadius.circular(30),
      ),
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(appController.usuarioLogado.urlImage),
                  backgroundColor: Colors.transparent,
                  radius: 22,
                ),
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  border: new Border.all(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 7, vertical: 1),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      appController.usuarioLogado.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    appController.usuarioLogado.nickName,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "25 publicações",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Icon(
            Icons.keyboard_arrow_right_rounded,
            size: 35,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _cardAvaliacao(Feed feed) {
    double alturaCard = 105;

    return InkWell(
      onTap: () => Modular.to.pushNamed('/feed/details', arguments: feed),
      child: Container(
        margin: EdgeInsets.only(top: 7, bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: <BoxShadow>[shadow()],
        ),
        child: Column(
          children: [
            Container(
              height: alturaCard,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                    ),
                    child: Image.network(
                      feed.urlImage,
                      fit: BoxFit.cover,
                      width: 100,
                      height: alturaCard,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      height: alturaCard,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                backgroundImage: NetworkImage("${feed.urlImageUser}"),
                                radius: 14,
                              ),
                              SizedBox(width: 10),
                              Text(
                                feed.nickNameUser,
                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Text(
                            feed.evaluationUser,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Icon(Icons.thumb_up_alt_outlined),
                          ),
                          SizedBox(width: 5),
                          Text(
                            feed.like.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Icon(Icons.thumb_down_alt_outlined),
                          ),
                          SizedBox(width: 5),
                          Text(
                            feed.dislike.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    "Postado em " + feed.dateEvaluationCreate,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
