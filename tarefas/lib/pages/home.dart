import 'package:flutter/material.dart';
import 'package:tarefas/models/tarefa.dart';

class Home extends StatefulWidget {
  var tarefas = new List<Tarefa>();
  var teste = 0;

  Home() {
    tarefas = [];
    tarefas.add(new Tarefa(id: 1, descricao: 'Lavar louça', pronta: true));
    tarefas.add(new Tarefa(id: 2, descricao: 'Estudar', pronta: false));
    tarefas.add(new Tarefa(id: 3, descricao: 'Pagar boleto', pronta: false));
  }
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
    );
  }
}
