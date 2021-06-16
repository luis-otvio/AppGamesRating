import 'package:app_games_rating/app/app_store.dart';
import 'package:app_games_rating/app/modules/feed/model/feed_details_model.dart';
import 'package:app_games_rating/app/modules/feed/page/feed_store.dart';
import 'package:app_games_rating/app/modules/shared/widgets/shadow_widget.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:like_button/like_button.dart';

class FeedDetailsPage extends StatefulWidget {
  final FeedDetails feedDetails;
  FeedDetailsPage(this.feedDetails);

  @override
  FeedDetailsPageState createState() => FeedDetailsPageState();
}

class FeedDetailsPageState extends State<FeedDetailsPage> {
  final appController = Modular.get<AppStore>();
  final feedController = Modular.get<FeedStore>();
  final GlobalKey<LikeButtonState> _likeKey = GlobalKey<LikeButtonState>();
  final GlobalKey<LikeButtonState> _dislikeKey = GlobalKey<LikeButtonState>();

  bool _isLiked;
  bool _isDisliked;

  bool _isEditable = false;

  String avaliacao = "";

  @override
  void initState() {
    _isLiked = widget.feedDetails.curtido;
    _isDisliked = widget.feedDetails.descurtido;

    avaliacao = widget.feedDetails.feed.evaluationUser;

    if (widget.feedDetails.feed.idUser == appController.usuarioLogado.id) {
      setState(() {
        _isEditable = true;
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle btnEditarStyle = ElevatedButton.styleFrom(primary: Colors.blue[600]);
    final ButtonStyle btnDeletarStyle = ElevatedButton.styleFrom(primary: Colors.red[600]);

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
                  image: NetworkImage(widget.feedDetails.feed.urlImage),
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
                    widget.feedDetails.feed.titleGame,
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage("${widget.feedDetails.feed.urlImageUser}"),
                        radius: 14,
                      ),
                      SizedBox(width: 10),
                      Text(
                        widget.feedDetails.feed.nickNameUser,
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Visibility(
                    visible: _isEditable,
                    child: Opacity(
                      opacity: _isEditable ? 1 : 0,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: btnEditarStyle,
                                  onPressed: () async {
                                    String novaAvaliacao = await Modular.to.pushNamed('/feed/edit', arguments: widget.feedDetails);
                                    setState(() {
                                      avaliacao = novaAvaliacao;
                                    });
                                  },
                                  child: Text('Editar Post'),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: ElevatedButton(
                                  style: btnDeletarStyle,
                                  onPressed: () async {
                                    CoolAlert.show(
                                      context: context,
                                      type: CoolAlertType.confirm,
                                      text: 'Deseja realmente deletar essa avaliação?',
                                      title: 'Confirmação',
                                      confirmBtnText: 'Sim',
                                      cancelBtnText: 'Não',
                                      confirmBtnColor: Colors.red,
                                      onConfirmBtnTap: () => _deletarPost(),
                                    );
                                  },
                                  child: Text('Deletar Post'),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Postado em " + widget.feedDetails.feed.dateEvaluationCreate,
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "“" + avaliacao + "”",
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        constraints: BoxConstraints(
          minHeight: 10.0,
          minWidth: double.infinity,
          maxHeight: 150.0,
        ),
        decoration: BoxDecoration(
          boxShadow: [shadow()],
          color: Colors.white,
        ),
        padding: EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            LikeButton(
              key: _likeKey,
              isLiked: _isLiked,
              circleColor: CircleColor(start: Color(0xFFFF879B), end: Color(0xFFFF5656)),
              bubblesColor: BubblesColor(dotPrimaryColor: Color(0xFFFF879B), dotSecondaryColor: Color(0xFFFF5656)),
              likeBuilder: (bool isLiked) {
                return Icon(
                  isLiked ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                  color: isLiked ? Colors.redAccent : Colors.grey,
                );
              },
              likeCount: widget.feedDetails.feed.like,
              countBuilder: (int count, bool isLiked, String text) {
                var color = isLiked ? Colors.redAccent : Colors.grey;
                Widget result = Text(text, style: TextStyle(color: color));
                return result;
              },
              onTap: (bool isLiked) async => onLikeButtonTapped(isLiked, widget.feedDetails.feed.idEvaluation),
            ),
            SizedBox(width: 10),
            LikeButton(
              key: _dislikeKey,
              isLiked: _isDisliked,
              circleColor: CircleColor(start: Color(0xFFFF879B), end: Color(0xFFFF5656)),
              bubblesColor: BubblesColor(dotPrimaryColor: Color(0xFFFF879B), dotSecondaryColor: Color(0xFFFF5656)),
              likeBuilder: (bool isDisliked) {
                return Icon(
                  isDisliked ? Icons.thumb_down : Icons.thumb_down_alt_outlined,
                  color: isDisliked ? Colors.redAccent : Colors.grey,
                );
              },
              likeCount: widget.feedDetails.feed.dislike,
              countBuilder: (int count, bool isDisliked, String text) {
                var color = isDisliked ? Colors.redAccent : Colors.grey;
                Widget result = Text(text, style: TextStyle(color: color));
                return result;
              },
              onTap: (bool isDisliked) async => onDislikeButtonTapped(isDisliked, widget.feedDetails.feed.idEvaluation),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> onLikeButtonTapped(bool isLiked, int idEvaluation) async {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.loading,
      text: "Carregando...",
      barrierDismissible: false,
    );

    // remove o dislike, caso esteja
    if (!isLiked && _isDisliked) {
      _dislikeKey.currentState.onTap();
    }

    _isLiked = !isLiked;

    await feedController.likeDislikeFeed(!isLiked ? 1 : 3, appController.usuarioLogado.id, idEvaluation, appController.usuarioLogado.accessToken).onError((error, stackTrace) {
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
    });

    Modular.to.pop();

    return !isLiked;
  }

  Future<bool> onDislikeButtonTapped(bool isDisliked, int idEvaluation) async {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.loading,
      text: "Carregando...",
      barrierDismissible: false,
    );

    // remove o dislike, caso esteja
    if (!isDisliked && _isLiked) {
      _likeKey.currentState.onTap();
    }

    _isDisliked = !isDisliked;

    await feedController
        .likeDislikeFeed(
      !isDisliked ? 2 : 3,
      appController.usuarioLogado.id,
      idEvaluation,
      appController.usuarioLogado.accessToken,
    )
        .onError((error, stackTrace) {
      Modular.to.pop();
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
    });

    Modular.to.pop();

    return !isDisliked;
  }

  _deletarPost() async {
    Modular.to.pop();
    CoolAlert.show(
      context: context,
      type: CoolAlertType.loading,
      text: "Carregando...",
      barrierDismissible: false,
    );

    await feedController.deleteFeed(widget.feedDetails.feed.idEvaluation, appController.usuarioLogado.accessToken).then((value) {
      Modular.to.pushReplacementNamed('/feed');
    }).onError((error, stackTrace) {
      Modular.to.pop();
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
    });
  }
}
