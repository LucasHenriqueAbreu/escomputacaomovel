import 'package:flutter/material.dart';

class Cadastro extends StatelessWidget {
  TextEditingController tfDescricao = TextEditingController();

  void _enviarDados(BuildContext context, String descricao) {
    Navigator.pop(context, descricao);
  }

  Widget _criaInputTexto() {
    return TextFormField(
      autofocus: true,
      controller: tfDescricao,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20.0, color: Colors.white),
      decoration: InputDecoration(
        labelText: 'Descrição da tarefa',
        labelStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _criaBotao(BuildContext context) {
    return ButtonTheme(
      height: 60.0,
      child: RaisedButton(
        color: Colors.white,
        child: Text(
          'Salvar',
          style: TextStyle(color: Colors.teal),
        ),
        onPressed: () {
          _enviarDados(context, tfDescricao.text);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _criaInputTexto(),
              Divider(),
              _criaBotao(context)
            ],
          ),
        ),
      ),
    );
  }
}
