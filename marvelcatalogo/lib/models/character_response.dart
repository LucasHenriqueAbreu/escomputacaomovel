import 'package:marvelcatalogo/models/models.dart';

class CharacterDataWrapper {
  CharacterDataContainer data;

  CharacterDataWrapper(this.data);

  CharacterDataWrapper.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new CharacterDataContainer.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
  }
}

class CharacterDataContainer {
  int offset;
  int limit;
  int total;
  int count;
  List<Character> characters;

  CharacterDataContainer({this.offset, this.limit, this.total, this.count, this.characters});

  CharacterDataContainer.fromJson(Map<String, dynamic> json) {
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