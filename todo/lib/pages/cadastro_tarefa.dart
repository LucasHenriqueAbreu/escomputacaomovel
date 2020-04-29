import 'package:flutter/material.dart';
import 'package:todo/daos/tarefa_dao.dart';
import 'package:todo/models/tarefa.dart';

class CadastroTarefa extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  Tarefa tarefa = Tarefa();
  TarefaDao tarefaDao = TarefaDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de tarefas'),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: _criaForm(),
      ),
    );
  }

  /// Método responsável por criar o form.
  Form _criaForm() {
    return Form(
      key: _form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _criaInputDescricao(),
          SizedBox(
            height: 10,
          ),
          _criaBotaoSalvar(),
        ],
      ),
    );
  }

  /// Método responsável por criar o input de descriçao.
  TextFormField _criaInputDescricao() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Descrição',
        hintText: 'Informe a descrição de sua atividade',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Descrição é obrigatória';
        }
        return null;
      },
      onSaved: (value) {
        tarefa.descricao = value;
      },
    );
  }

  Widget _criaBotaoSalvar() {
    return RaisedButton(
      child: Text(
        'Salvar',
      ),
      onPressed: _salvar,
    );
  }

  void _salvar() async {
    var formValido = _form.currentState.validate();
    if (formValido) {
      _form.currentState.save();
      tarefa.pronta = false;
      await tarefaDao.create(tarefa);
      _form.currentState.reset();
    }
  }
}
