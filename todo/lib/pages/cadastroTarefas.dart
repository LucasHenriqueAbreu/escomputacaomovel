import 'package:flutter/material.dart';

class CadadastroTarefas extends StatefulWidget {
  @override
  _CadadastroTarefasState createState() => _CadadastroTarefasState();
}

class _CadadastroTarefasState extends State<CadadastroTarefas> {
  TextEditingController tfNomeTarefaController = TextEditingController();

  void _sendDataBack(BuildContext context) {
    String textToSendBack = tfNomeTarefaController.text;
    Navigator.pop(context, textToSendBack);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                autofocus: true,
                controller: tfNomeTarefaController,
                keyboardType: TextInputType.text,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  labelText: 'NOME',
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Divider(),
              ButtonTheme(
                height: 60.0,
                child: RaisedButton(
                  color: Colors.white,
                  child: Text(
                    'Salvar',
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () {
                    _sendDataBack(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
