import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/tarefa.dart';

import 'cadastroTarefas.dart';

class Home extends StatefulWidget {
  var tarefas = new List<Tarefa>();

  Home() {
    tarefas = [];
  }

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _abrirPaginaCadastroTarefa(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CadadastroTarefas(),
        ));

    addTarefa(result);
  }

  void addTarefa(String result) {
    if (result != null && result.length > 0) {
      setState(() {
        widget.tarefas.add(new Tarefa(id: 1, descricao: result, pronta: false));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo'),
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
          _abrirPaginaCadastroTarefa(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
