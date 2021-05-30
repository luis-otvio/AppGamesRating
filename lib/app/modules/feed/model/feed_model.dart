class Feed {
  int idEvaluation;
  int idGame;
  int idUser;
  String nickNameUser;
  String evaluationUser;
  String titleGame;
  String urlImage;
  String urlImageUser;
  String dateEvaluationCreate;
  int like;
  int dislike;

  Feed(
      {this.idEvaluation,
      this.idGame,
      this.idUser,
      this.nickNameUser,
      this.evaluationUser,
      this.titleGame,
      this.urlImage,
      this.urlImageUser,
      this.dateEvaluationCreate,
      this.like,
      this.dislike});

  Feed.fromJson(Map<String, dynamic> json) {
    idEvaluation = json['idEvaluation'];
    idGame = json['idGame'];
    idUser = json['idUser'];
    nickNameUser = json['nickNameUser'];
    evaluationUser = json['evaluationUser'];
    titleGame = json['titleGame'];
    urlImage = json['urlImage'];
    urlImageUser = json['urlImageUser'];
    dateEvaluationCreate = json['dateEvaluationCreate'];
    like = json['like'];
    dislike = json['dislike'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idEvaluation'] = this.idEvaluation;
    data['idGame'] = this.idGame;
    data['idUser'] = this.idUser;
    data['nickNameUser'] = this.nickNameUser;
    data['evaluationUser'] = this.evaluationUser;
    data['titleGame'] = this.titleGame;
    data['urlImage'] = this.urlImage;
    data['urlImageUser'] = this.urlImageUser;
    data['dateEvaluationCreate'] = this.dateEvaluationCreate;
    data['like'] = this.like;
    data['dislike'] = this.dislike;
    return data;
  }
}
