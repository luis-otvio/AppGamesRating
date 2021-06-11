class LikeByUser {
  int idEvaluation;
  int idUser;
  int likeDit;

  LikeByUser({this.idEvaluation, this.idUser, this.likeDit});

  LikeByUser.fromJson(Map<String, dynamic> json) {
    idEvaluation = json['idEvaluation'];
    idUser = json['idUser'];
    likeDit = json['likeDit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idEvaluation'] = this.idEvaluation;
    data['idUser'] = this.idUser;
    data['likeDit'] = this.likeDit;
    return data;
  }
}
