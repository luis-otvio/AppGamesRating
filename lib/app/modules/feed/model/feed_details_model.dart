import 'package:app_games_rating/app/modules/feed/model/feed_model.dart';

class FeedDetails {
  Feed feed;
  bool curtido;
  bool descurtido;

  FeedDetails({this.feed, this.curtido, this.descurtido});

  FeedDetails.fromJson(Map<String, dynamic> json) {
    feed = json['feed'];
    curtido = json['curtido'];
    descurtido = json['descurtido'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['feed'] = this.feed;
    data['curtido'] = this.curtido;
    data['descurtido'] = this.descurtido;
    return data;
  }
}
