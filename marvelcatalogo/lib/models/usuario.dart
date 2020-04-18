class Usuario {
  int id;
  String userName;
  String publicKey;
  String privateKey;

  Usuario({this.id, this.userName, this.publicKey, this.privateKey});

  Usuario.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    publicKey = json['publicKey'];
    privateKey = json['privateKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['publicKey'] = this.publicKey;
    data['privateKey'] = this.privateKey;
    return data;
  }
}
