import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/daos/tarefa_dao.dart';
import 'package:todo/models/tarefa.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Tarefa> tarefas = [
    Tarefa(id: 1, descricao: 'Teste 1', pronta: true),
    Tarefa(id: 2, descricao: 'Teste 2', pronta: true),
    Tarefa(id: 3, descricao: 'Teste 3', pronta: false),
  ];
  final _form = GlobalKey<FormState>();
  Tarefa tarefa = Tarefa();
  TarefaDao tarefaDao = TarefaDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO - app'),
      ),
      body: _criaLista(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showDialogCadstro();
        },
      ),
    );
  }

  ///Método responsável por criar a lista de tarefas (ListView).
  Widget _criaLista() {
    return ListView.builder(
      ///Parâmetro da função builder do ListView, responsável
      ///por dizer quantos itens a listava vai possuir, assim
      ///o ListView sabe quantas vezes vai repetir o itemBuilder.
      itemCount: tarefas.length,

      ///Parâmetro da função builder, responsável por
      ///criar cada item da lista de tarefas.
      itemBuilder: (BuildContext context, int index) {
        final tarefa = tarefas[index];
        return _criaItemLista(tarefa);
      },
    );
  }

  /// Método responsável por criar o item do listView
  Widget _criaItemLista(Tarefa tarefa) {
    return CheckboxListTile(
      title: Text(tarefa.descricao),
      value: tarefa.pronta,
      onChanged: (value) {
        setState(() {
          tarefa.pronta = value;
        });
      },
    );
  }

  /// Método responsável por abriro nosso dialog de cadadastro.
  void _showDialogCadstro() {
    showDialog(context: context, builder: (_) => _criaDialogCadastro());
  }

  /// Método responsável por criar o nosso AlertDialog
  AlertDialog _criaDialogCadastro() {
    return AlertDialog(
      title: Text('Cadastro de tarefas'),
      content: _criaForm(),
      actions: <Widget>[
        FlatButton(
          child: Text(
            'Cancelar',
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text(
            'Salvar',
          ),
          onPressed: () {
            _salvar();
          },
        ),
      ],
    );
  }

  /// Método responsável por criar o form.
  Form _criaForm() {
    return Form(
      key: _form,
      child: Column(
        children: <Widget>[
          _criaInputDescricao(),
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
      maxLines: 3,
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

  void _salvar() async {
    var formValido = _form.currentState.validate();
    if (formValido) {
      _form.currentState.save();
      var id = await tarefaDao.create(tarefa);
      print(id);
    }
  }
}
