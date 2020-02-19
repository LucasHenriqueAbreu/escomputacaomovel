class Tarefa {
  int id;
  String descricao;
  bool pronta;

  Tarefa({this.id, this.descricao, this.pronta});

  Tarefa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
    pronta = json['pronta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['descricao'] = this.descricao;
    data['pronta'] = this.pronta;
    return data;
  }
}
