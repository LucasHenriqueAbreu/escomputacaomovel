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
    return RefreshIndicator(
      onRefresh: () async {
        _buscaTarefas();
      },
      child: ListView.builder(
        ///Parâmetro da função builder do ListView, responsável
        ///por dizer quantos itens a listava vai possuir, assim
        ///o ListView sabe quantas vezes vai repetir o itemBuilder.
        itemCount: tarefas.length,

        ///Parâmetro da função builder, responsável por
        ///criar cada item da lista de tarefas.
        itemBuilder: _criaItemBuilder,
      ),
    );
  }

  /// Método responsável por criar o itemBuilder
  ///Parâmetro da função builder, responsável por
  ///criar cada item da lista de tarefas.
  Widget _criaItemBuilder(BuildContext context, int index) {
    final tarefa = tarefas[index];
    return Builder(builder: (BuildContext context) {
      return Dismissible(
        key: Key(tarefa.id.toString()),
        child: _criaItemLista(tarefa),
        onDismissed: (DismissDirection dismissDirection) {
          if (dismissDirection == DismissDirection.endToStart) {
            _removeTarefa(tarefa, index, context);
          } else if (dismissDirection == DismissDirection.startToEnd) {
            tarefa.pronta = true;
            tarefaDao.update(tarefa);
          }
          tarefas.removeAt(index);
        },
        background: Container(
          color: Colors.green,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.done,
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 3),
                  child: Text(
                    'Tarefa pronta...',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          alignment: Alignment.centerLeft,
        ),
        secondaryBackground: Container(
          color: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 3),
                child: Text(
                  'Removendo tarefa...',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ],
          ),
          alignment: Alignment.centerRight,
        ),
      );
    });
  }

  /// Método responsável por criar o item do listView
  Widget _criaItemLista(Tarefa tarefa) {
    return ListTile(
      title: Text(tarefa.descricao),
      subtitle: Text(tarefa.descricao),
    );
  }

  /// Método responsável por abriro nosso dialog de cadadastro.
  void _abrirTelaCadastro() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return CadastroTarefa();
        },
      ),
    );
    _buscaTarefas();
  }

  // Busca as tarefas no banco de dados
  _buscaTarefas() async {
    var result = await tarefaDao.list();
    setState(() {
      tarefas = result;
    });
  }

  void _removeTarefa(Tarefa tarefa, int index, BuildContext context) {
    setState(() {
      tarefas.removeAt(index);
    });
    final snackBar = SnackBar(
      duration: Duration(seconds: 5),
      content: Text(
        'Você removeu a tarefa ${tarefa.descricao}',
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
      action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () {
            setState(() {
              tarefas.insert(index, tarefa);
            });
          }),
    );
    Scaffold.of(context).showSnackBar(snackBar).closed.then((reason) {
      if (reason != SnackBarClosedReason.action) {
        tarefaDao.delete(tarefa.id);
      }
    });
  }
}
