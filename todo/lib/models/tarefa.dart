class Tarefa {
  int id;
  String descricao;
  bool pronta;

  Tarefa({this.id, this.descricao, this.pronta});

  Tarefa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
    if (json['pronta'] == 0) {
      pronta = false;
    } else if (json['pronta'] == 1) {
      pronta = true;
    } else {
      pronta = false;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['descricao'] = this.descricao;
    data['pronta'] = this.pronta ? 1 : 0;
    return data;
  }
}
