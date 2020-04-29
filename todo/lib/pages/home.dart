import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/daos/tarefa_dao.dart';
import 'package:todo/models/tarefa.dart';
import 'package:todo/pages/cadastro_tarefa.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Tarefa> tarefas = List<Tarefa>();
  TarefaDao tarefaDao = TarefaDao();

  @override
  void initState() {
    _buscaTarefas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO - app'),
      ),
      body: _criaLista(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _abrirTelaCadastro,
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
      itemBuilder: _criaItemBuilder,
    );
  }

  /// Método responsável por criar o itemBuilder
  ///Parâmetro da função builder, responsável por
  ///criar cada item da lista de tarefas.
  Widget _criaItemBuilder(BuildContext context, int index) {
    final tarefa = tarefas[index];
    return _criaItemLista(tarefa);
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
  void _abrirTelaCadastro() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return CadastroTarefa();
        },
      ),
    );
  }

  // Busca as tarefas no banco de dados
  _buscaTarefas() async {
    var result = await tarefaDao.list();
    setState(() {
      tarefas = result;
    });
  }
}
