import 'package:app_games_rating/app/modules/feed/model/feed_model.dart';
import 'package:app_games_rating/app/modules/shared/widgets/shadow_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

cardAvaliacao(Feed feed, bool exibirUsuario, bool exibirLikes) {
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
                      mainAxisAlignment: exibirUsuario ? MainAxisAlignment.spaceAround : MainAxisAlignment.center,
                      children: [
                        exibirUsuario
                            ? Row(
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
                              )
                            : Container(),
                        Text(
                          feed.evaluationUser,
                          maxLines: exibirUsuario ? 3 : 5,
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
              mainAxisAlignment: exibirLikes ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
              children: [
                exibirLikes
                    ? Row(
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
                      )
                    : Container(),
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
