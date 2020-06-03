class Pessoa {
  String sId;
  int index;
  String guid;
  bool isActive;
  String balance;
  String picture;
  int age;
  String eyeColor;
  String name;
  String gender;
  String company;
  String email;
  String phone;
  String address;
  String about;
  String registered;
  double latitude;
  double longitude;
  List<String> tags;
  List<Friends> friends;
  String greeting;
  String favoriteFruit;

  Pessoa(
      {this.sId,
      this.index,
      this.guid,
      this.isActive,
      this.balance,
      this.picture,
      this.age,
      this.eyeColor,
      this.name,
      this.gender,
      this.company,
      this.email,
      this.phone,
      this.address,
      this.about,
      this.registered,
      this.latitude,
      this.longitude,
      this.tags,
      this.friends,
      this.greeting,
      this.favoriteFruit});

  Pessoa.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    index = json['index'];
    guid = json['guid'];
    isActive = json['isActive'];
    balance = json['balance'];
    picture = json['picture'];
    age = json['age'];
    eyeColor = json['eyeColor'];
    name = json['name'];
    gender = json['gender'];
    company = json['company'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    about = json['about'];
    registered = json['registered'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    tags = json['tags'].cast<String>();
    if (json['friends'] != null) {
      friends = new List<Friends>();
      json['friends'].forEach((v) {
        friends.add(new Friends.fromJson(v));
      });
    }
    greeting = json['greeting'];
    favoriteFruit = json['favoriteFruit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['index'] = this.index;
    data['guid'] = this.guid;
    data['isActive'] = this.isActive;
    data['balance'] = this.balance;
    data['picture'] = this.picture;
    data['age'] = this.age;
    data['eyeColor'] = this.eyeColor;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['company'] = this.company;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['about'] = this.about;
    data['registered'] = this.registered;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['tags'] = this.tags;
    if (this.friends != null) {
      data['friends'] = this.friends.map((v) => v.toJson()).toList();
    }
    data['greeting'] = this.greeting;
    data['favoriteFruit'] = this.favoriteFruit;
    return data;
  }
}

class Friends {
  int id;
  String name;

  Friends({this.id, this.name});

  Friends.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
