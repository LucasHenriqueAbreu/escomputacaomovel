import 'package:flutter/material.dart';
import 'package:tarefas/models/tarefa.dart';
import 'package:tarefas/pages/cadastro.dart';

class Home extends StatefulWidget {
  var tarefas = new List<Tarefa>();

  Home() {
    tarefas = [];
  }
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _abrirCadastro(BuildContext context) async {
    final descricao = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Cadastro()),
    );
    _addTarefa(descricao);
  }

  _addTarefa(String descricao) {
    setState(() {
      widget.tarefas.add(
        new Tarefa(
            id: widget.tarefas.length + 1, descricao: descricao, pronta: false),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarefas '),
        actions: <Widget>[
          PopupMenuButton(itemBuilder: (BuildContext contect) {
            return [
              PopupMenuItem(child: Text('Feitas')),
              PopupMenuItem(child: Text('A fazer'))
            ];
          })
        ],
      ),
      body: ListView.builder(
        itemCount: widget.tarefas.length,
        itemBuilder: (BuildContext ct, int index) {
          final tarefa = widget.tarefas[index];
          return CheckboxListTile(
            title: Text(tarefa.descricao),
            key: Key(tarefa.id.toString()),
            value: tarefa.pronta,
            onChanged: (value) {
              setState(() {
                tarefa.pronta = value;
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _abrirCadastro(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
