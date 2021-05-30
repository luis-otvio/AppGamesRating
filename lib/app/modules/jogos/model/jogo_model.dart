class Jogo {
  int id;
  String title;
  String description;
  String producer;
  String platforms;
  String urlImage;
  int note;

  Jogo({this.id, this.title, this.description, this.producer, this.platforms, this.urlImage, this.note});

  Jogo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    producer = json['producer'];
    platforms = json['platforms'];
    urlImage = json['urlImage'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['producer'] = this.producer;
    data['platforms'] = this.platforms;
    data['urlImage'] = this.urlImage;
    data['note'] = this.note;
    return data;
  }
}
