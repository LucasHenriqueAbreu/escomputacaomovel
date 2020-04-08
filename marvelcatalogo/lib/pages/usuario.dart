import 'package:flutter/material.dart';

class Usuario extends StatefulWidget {
  @override
  _UsuarioState createState() => _UsuarioState();
}

class _UsuarioState extends State<Usuario> {
  final _formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Usuário'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formGlobalKey,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _criaTextFormField(
                  'Username',
                  hintText: 'Informe o username da sua conta Marvel Dev',
                  validator: _validaUserName,
                ),
                SizedBox(
                  height: 20.0,
                ),
                //Informe sua chave pública da conta Marvel Dev
                _criaTextFormField(
                  'Public Key',
                  validator: _validaChavePublica,
                ),
                SizedBox(
                  height: 20.0,
                ),
                _criaTextFormField(
                  'Private Key',
                  hintText: 'Informe sua chave privada da conta Marvel Dev',
                  validator: _validaChavePrivada,
                ),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  child: Text(
                    'Salvar',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    if (_formGlobalKey.currentState.validate()) {
                      _showMsg(context, 'Teste');
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _criaTextFormField(String labelText,
      {String hintText, Function validator}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
      validator: validator,
    );
  }

  String _validaUserName(String value) {
    if (value.isEmpty) {
      return 'Por favor, informe seu username, ele é obrigatório';
    }
    return null;
  }

  String _validaChavePublica(String value) {
    if (value.isEmpty) {
      return 'Por favor, informe a chave pública, ela é obrigatória';
    }
    if (value.length < 3) {
      return 'Tem certeza que está correta? Geralmente este campo é bem maior!';
    }
    return null;
  }

  String _validaChavePrivada(String value) {
    if (value.isEmpty) {
      return 'Por favor, informe a chave privada, ela é obrigatória';
    }
    if (value.length < 3) {
      return 'Tem certeza que está correta? Geralmente este campo é bem maior!';
    }
    return null;
  }

  _showMsg(BuildContext context, String msg) {
    final snackbar = SnackBar(
      content: Text(msg),
    );
    Scaffold.of(context).showSnackBar(snackbar);
  }
}
