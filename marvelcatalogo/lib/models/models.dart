class CharactersResponse {
  Data data;

  CharactersResponse(this.data);

  CharactersResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
  }
}

class Data {
  int offset;
  int limit;
  int total;
  int count;
  List<Character> characters;

  Data({this.offset, this.limit, this.total, this.count, this.characters});

  Data.fromJson(Map<String, dynamic> json) {
    offset = json['offset'];
    limit = json['limit'];
    total = json['total'];
    count = json['count'];
    if (json['results'] != null) {
      characters = new List<Character>();
      json['results'].forEach((v) {
        characters.add(new Character.fromJson(v)); // corno
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offset'] = this.offset;
    data['limit'] = this.limit;
    data['total'] = this.total;
    data['count'] = this.count;
    if (this.characters != null) {
      data['results'] = this.characters.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Character {
  int id;
  String name;
  String description;
  Thumbnail thumbnail;

  Character({
    this.id, 
    this.name,
    this.description,
    this.thumbnail
  });

  Character.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['deion'];
    thumbnail = json['thumbnail'] != null
        ? new Thumbnail.fromJson(json['thumbnail'])
        : null;
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['deion'] = this.description;
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
