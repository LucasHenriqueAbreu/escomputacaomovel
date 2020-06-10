import 'package:flutter/material.dart';
import 'package:jogo_da_memoria/models/carta.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Carta> cartas = [
    Carta(id: 1, grupo: 1, cor: Colors.amber),
    Carta(id: 2, grupo: 1, cor: Colors.amber),
    Carta(id: 3, grupo: 2, cor: Colors.blue),
    Carta(id: 4, grupo: 2, cor: Colors.blue),
    Carta(id: 5, grupo: 3, cor: Colors.orange),
    Carta(id: 6, grupo: 3, cor: Colors.orange),
    Carta(id: 7, grupo: 4, cor: Colors.brown),
    Carta(id: 8, grupo: 4, cor: Colors.brown),
    Carta(id: 9, grupo: 5, cor: Colors.teal),
    Carta(id: 10, grupo: 5, cor: Colors.teal),
    Carta(id: 11, grupo: 6, cor: Colors.cyan),
    Carta(id: 12, grupo: 6, cor: Colors.cyan),
    Carta(id: 13, grupo: 7, cor: Colors.black),
    Carta(id: 14, grupo: 7, cor: Colors.black),
    Carta(id: 15, grupo: 8, cor: Colors.green),
    Carta(id: 16, grupo: 8, cor: Colors.green)
  ];

  List<Carta> cartasSelecionadas = [];

  int _ponto = 0;

  @override
  void initState() {
    cartas.shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 243, 243, 1),
      appBar: AppBar(
        title: Text('Jogo da memória'),
      ),
      body: _criaTabuleiroCartas(),
    );
  }

  Widget _criaTabuleiroCartas() {
    return GridView.count(
      padding: EdgeInsets.all(20.0),
      crossAxisCount: 4,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: _criaListaCartas(),
    );
  }

  List<Widget> _criaListaCartas() {
    List<Widget> resposta = [];
    for (var i = 0; i < cartas.length; i++) {
      resposta.add(_criaCarta(cartas[i]));
    }
    return resposta;
  }

  Widget _criaCarta(Carta carta) {
    return GestureDetector(
      onTap: () => _mostraCarta(carta),
      child: Card(
        child: AnimatedContainer(
          color: carta.selecionada ? carta.cor : Colors.red,
          duration: Duration(milliseconds: 400),
          child: Center(
            child: _criaConteudoCarta(carta),
          ),
        ),
      ),
    );
  }

  Widget _criaConteudoCarta(Carta carta) {
    if (carta.selecionada) {
      return Text(
        carta.grupo.toString(),
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      );
    } else {
      return Container();
    }
  }

  _mostraCarta(Carta carta) {
    if (cartasSelecionadas.length == 2) {
      _verificaAcerto();
    }
    setState(() {
      carta.selecionada = !carta.selecionada;
    });
    cartasSelecionadas.add(carta);
  }

  _verificaAcerto() {
    if (cartasSelecionadas[0].grupo == cartasSelecionadas[1].grupo) {
      setState(() {
        _ponto += 1;
      });
      _validaVitoria();
    } else {
      cartasSelecionadas[0].selecionada = false;
      cartasSelecionadas[1].selecionada = false;
    }
    cartasSelecionadas = [];
  }

  void _validaVitoria() {
    if (_ponto == 8) {
      _mostraMsgVitoria();
    }
  }

  void _limpaTabuleiro() {
    setState(() {
      _ponto = 0;
      cartas.shuffle();
      for (var i = 0; i < cartas.length; i++) {
        cartas[i].selecionada = false;
      }
    });
  }

  void _mostraMsgVitoria() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Vitória'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Você acertou todas as cartas.'),
                Text('Deseja jogar novamente?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Não'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Sim'),
              onPressed: () {
                _limpaTabuleiro();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
