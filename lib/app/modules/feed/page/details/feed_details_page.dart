import 'package:app_games_rating/app/modules/feed/model/feed_model.dart';
import 'package:app_games_rating/app/modules/shared/widgets/shadow_widget.dart';
import 'package:flutter/material.dart';

class FeedDetailsPage extends StatefulWidget {
  final Feed feed;
  FeedDetailsPage(this.feed);

  @override
  FeedDetailsPageState createState() => FeedDetailsPageState();
}

class FeedDetailsPageState extends State<FeedDetailsPage> {
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
          "Detalhes do Post",
          style: TextStyle(color: Colors.red[700]),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.feed.urlImage),
                  fit: BoxFit.cover,
                ),
              ),
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 4,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.feed.titleGame,
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage("${widget.feed.urlImageUser}"),
                        radius: 14,
                      ),
                      SizedBox(width: 10),
                      Text(
                        widget.feed.nickNameUser,
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Postado em " + widget.feed.dateEvaluationCreate,
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "“" + widget.feed.evaluationUser + "”",
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [shadow()],
          color: Colors.white,
        ),
        padding: EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Icon(Icons.thumb_up_alt_outlined),
                    ),
                    SizedBox(width: 5),
                    Text(
                      widget.feed.like.toString(),
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
                      widget.feed.dislike.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Icon(Icons.comment_rounded),
                ),
                SizedBox(width: 5),
                Text(
                  widget.feed.like.toString() + " comentários",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
