import 'package:app_games_rating/app/modules/jogos/model/jogo_model.dart';
import 'package:app_games_rating/app/modules/shared/widgets/shadow_widget.dart';
import 'package:flutter/material.dart';

class JogosDetailsPage extends StatefulWidget {
  final Jogo jogo;
  JogosDetailsPage(this.jogo);

  @override
  JogosDetailsPageState createState() => JogosDetailsPageState();
}

class JogosDetailsPageState extends State<JogosDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF879B),
        elevation: 0,
        titleSpacing: 0,
        centerTitle: true,
        title: Text("Detalhes do Jogo"),
      ),
      body: Container(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              _containerUsuario(),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Descrição:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.jogo.description,
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Disponível para:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(widget.jogo.platforms),
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
      padding: EdgeInsets.only(bottom: 30, top: 70),
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(widget.jogo.urlImage),
          fit: BoxFit.cover,
        ),
        boxShadow: [shadow()],
      ),
      child: Container(
        margin: EdgeInsets.only(top: 80),
        padding: EdgeInsets.symmetric(vertical: 20),
        color: Colors.black.withOpacity(0.7),
        child: Column(
          children: [
            Text(
              widget.jogo.title,
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
                widget.jogo.producer,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
