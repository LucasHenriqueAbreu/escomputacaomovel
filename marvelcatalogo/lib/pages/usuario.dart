import 'package:flutter/material.dart';

class Usuario extends StatefulWidget {
  @override
  _UsuarioState createState() => _UsuarioState();
}

class _UsuarioState extends State<Usuario> {
  final _formGlobalKey = GlobalKey<FormState>();
  String _username;
  final _tfPublicKeyController = TextEditingController();

  @override
  void initState() {
    _tfPublicKeyController.addListener(() {
      print('Passsou aqui');
      print(_tfPublicKeyController.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    _tfPublicKeyController.dispose();
    super.dispose();
  }

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
                  saved: (value) => _username = value,
                ),
                SizedBox(
                  height: 20.0,
                ),
                //Informe sua chave pública da conta Marvel Dev
                _criaTextFormField(
                  'Public Key',
                  validator: _validaChavePublica,
                  controller: _tfPublicKeyController,
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
                    bool formValido = _formGlobalKey.currentState.validate();
                    print(_username);
                    if (formValido) {
                      print('Form válido');
                      _formGlobalKey.currentState.save();
                      print(_username);
                      print(_tfPublicKeyController.text);
                    } else {
                      print('Form inválido');
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
      {String hintText,
      Function validator,
      Function saved,
      TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
      validator: validator,
      onSaved: saved,
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
}
