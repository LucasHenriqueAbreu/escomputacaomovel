class Character {
  int id;
  String name;
  String description;
  Thumbnail thumbnail;

  Character({this.id, this.name, this.description, this.thumbnail});

  Character.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description =
        json['description'] == null || json['description'].toString().isEmpty
            ? 'Não possui descrição'
            : json['description'];
    thumbnail = json['thumbnail'] != null
        ? new Thumbnail.fromJson(json['thumbnail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}

class Thumbnail {
  String path;
  String extension;

  Thumbnail({this.path, this.extension});

  Thumbnail.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    extension = json['extension'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['path'] = this.path;
    data['extension'] = this.extension;
    return data;
  }
}
