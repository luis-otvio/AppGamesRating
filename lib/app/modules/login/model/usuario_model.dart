class Usuario {
  int id;
  String name;
  String nickName;
  String email;
  String urlImage;
  String birthDate;
  String dateCreated;

  Usuario({this.id, this.name, this.nickName, this.email, this.urlImage, this.birthDate, this.dateCreated});

  Usuario.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nickName = json['nickname'];
    email = json['email'];
    urlImage = json['urlImage'];
    birthDate = json['birthDate'];
    dateCreated = json['dateCreated'];
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
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'nickname': this.nickName,
      'email': this.email,
      'urlImage': this.urlImage,
      'birthDate': this.birthDate,
      'dateCreated': this.dateCreated,
    };
  }

  @override
  String toString() {
    return 'Usuario{id: ${this.id}, name: ${this.name}, nickName: ${this.nickName}, email: ${this.email}, urlImage: ${this.urlImage}, birthDate: ${this.birthDate}, dateCreated: ${this.dateCreated}}';
  }
}
