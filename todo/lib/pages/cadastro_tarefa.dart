import 'package:flutter/material.dart';
import 'package:todo/daos/tarefa_dao.dart';
import 'package:todo/models/tarefa.dart';

class CadastroTarefa extends StatefulWidget {
  @override
  _CadastroTarefaState createState() => _CadastroTarefaState();
}

class _CadastroTarefaState extends State<CadastroTarefa> {
  final _form = GlobalKey<FormState>();
  Tarefa tarefa = Tarefa();
  TarefaDao tarefaDao = TarefaDao();
  bool _continuarCadastrando = true;

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
          _criaCheckBoxContinuarSalvando(),
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
    return Builder(
      builder: (BuildContext context) {
        return ButtonTheme(
          height: 50,
          child: RaisedButton(
            color: Theme.of(context).primaryColor,
            child: Text(
              'Salvar',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              _salvar(context);
            },
          ),
        );
      },
    );
  }

  void _salvar(BuildContext context) async {
    var formValido = _form.currentState.validate();
    if (formValido) {
      _form.currentState.save();
      tarefa.pronta = false;
      await tarefaDao.create(tarefa);
      _form.currentState.reset();
      final _snackBar = SnackBar(
        content: Text('Tarefa cadastrada com sucesso'),
      );
      Scaffold.of(context).showSnackBar(_snackBar);
      if (!_continuarCadastrando) {
        Navigator.pop(context);
      }
    }
  }

  _criaCheckBoxContinuarSalvando() {
    return CheckboxListTile(
      onChanged: (bool value) {
        setState(() {
          _continuarCadastrando = value;
        });
      },
      value: _continuarCadastrando,
      title: Text('Deseja continuar cadastrando?'),
      subtitle: Text('Desmarque para voltar à lista ao salvar'),
    );
  }
}
