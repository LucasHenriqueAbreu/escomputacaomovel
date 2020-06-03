import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:widget_em_geral/models/pessoa.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    _buscaPessoas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Widges em geral'),
      ),
      body: FutureBuilder<List<Pessoa>>(
        future: _buscaPessoas(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.error != null) {
            return Center(
              child: Text('Ops, ocorreu um problema'),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return _criaListView(snapshot.data);
          } else {
            return Center(
              child: Text('teste'),
            );
          }
        },
      ),
    );
  }

  Future<List<Pessoa>> _buscaPessoas() async {
    try {
      Response response =
          await http.get('http://www.mocky.io/v2/5ed6f6523200007800274427');

      if (response.statusCode == 400) {
        throw Exception();
      }
      var json = jsonDecode(response.body);
      List<Pessoa> pessoas = List<Pessoa>();
      for (var i = 0; i < json.length; i++) {
        pessoas.add(Pessoa.fromJson(json[i]));
      }
      return pessoas;
    } catch (e) {
      return e;
    }
  }

  Widget _criaListView(List<Pessoa> pessoas) {
    return ListView.builder(
      itemCount: pessoas.length,
      itemBuilder: (context, index) {
        final Pessoa pessoa = pessoas[index];
        return _criaItemListView(pessoa);
      },
    );
  }

  Widget _criaItemListView(Pessoa pessoa) {
    return ListTile(
      leading: Image.network(pessoa.picture),
      title: Text(pessoa.name),
      subtitle: Text(pessoa.email),
      trailing: IconButton(
        icon: Icon(Icons.ac_unit),
      ),
    );
  }
}
