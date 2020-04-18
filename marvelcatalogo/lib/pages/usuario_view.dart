import 'package:flutter/material.dart';
import 'package:marvelcatalogo/dao/usuario_dao.dart';
import 'package:marvelcatalogo/models/usuario.dart';

class UsuarioView extends StatefulWidget {
  @override
  _UsuarioViewState createState() => _UsuarioViewState();
}

class _UsuarioViewState extends State<UsuarioView> {
  final _formGlobalKey = GlobalKey<FormState>();
  Usuario usuario = Usuario();
  UsuarioDao usuarioDao = UsuarioDao();
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _getUsuario();
  }

  _getUsuario() async {
    setState(() => loading = true);
    usuario = await usuarioDao.read();
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Usuário'),
      ),
      body: loading
          ? Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Carregando...',
                      style: TextStyle(fontSize: 15),
                    ),
                  )
                ],
              ),
            )
          : SingleChildScrollView(
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
                        onSaved: (value) => usuario.userName = value,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      //Informe sua chave pública da conta Marvel Dev
                      _criaTextFormField(
                        'Public Key',
                        validator: _validaChavePublica,
                        onSaved: (value) => usuario.publicKey = value,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      _criaTextFormField(
                        'Private Key',
                        hintText:
                            'Informe sua chave privada da conta Marvel Dev',
                        validator: _validaChavePrivada,
                        onSaved: (value) => usuario.privateKey = value,
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
                          bool formValido =
                              _formGlobalKey.currentState.validate();
                          if (formValido) {
                            _formGlobalKey.currentState.save();
                            usuarioDao.create(usuario);
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
      Function onSaved,
      TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
      validator: validator,
      onSaved: onSaved,
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
