class Usuario {
  dynamic id; // precisa ser dynamic para receber possíveis Strings do Google e Facebook
  String name;
  String nickName;
  String email;
  String urlImage;
  String birthDate;
  String dateCreated;
  String accessToken;

  Usuario({this.id, this.name, this.nickName, this.email, this.urlImage, this.birthDate, this.dateCreated, this.accessToken});

  Usuario.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nickName = json['nickname'];
    email = json['email'];
    urlImage = json['urlImage'];
    birthDate = json['birthDate'];
    dateCreated = json['dateCreated'];
    accessToken = json['accessToken'] != null ? json['accessToken'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['nickname'] = this.nickName;
    data['email'] = this.email;
    data['urlImage'] = this.urlImage;
    data['birthDate'] = this.birthDate;
    data['dateCreated'] = this.dateCreated;
    data['accessToken'] = this.accessToken;
    return data;
  }
}
