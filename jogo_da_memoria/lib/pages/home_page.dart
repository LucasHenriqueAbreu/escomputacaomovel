import 'dart:async';

import 'package:collection/collection.dart';
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

  int _ponto = 0;

  Map<int, List<Carta>> cartasAgrupadasPorGrupo = Map<int, List<Carta>>();

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
        title:
            Text('Jogo da memória. Pontos: ${cartasAgrupadasPorGrupo.length}'),
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
          color: carta.visivel ? carta.cor : Colors.red,
          duration: Duration(milliseconds: 400),
          child: Center(
            child: _criaConteudoCarta(carta),
          ),
        ),
      ),
    );
  }

  Widget _criaConteudoCarta(Carta carta) {
    if (carta.visivel) {
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
    setState(() {
      carta.visivel = !carta.visivel;
    });
    _verificaAcerto();
  }

  void _verificaAcerto() {
    List<Carta> cartasVisiveis =
        cartas.where((carta) => carta.visivel).toList();
    if (cartasVisiveis.length >= 2) {
      setState(() {
        cartasAgrupadasPorGrupo =
            groupBy(cartasVisiveis, (Carta carta) => carta.grupo);
      });

      List<Carta> cartasIncorretas = [];
      cartasAgrupadasPorGrupo.forEach((key, value) {
        if (value.length < 2) {
          cartasIncorretas.add(value[0]);
        }
      });
      if (cartasIncorretas.length >= 2) {
        _escondeCartas(cartasIncorretas);
      }
    }
  }

  void _validaVitoria() {
    if (cartasAgrupadasPorGrupo.length == 8) {
      _mostraMsgVitoria();
    }
  }

  void _limpaTabuleiro() {
    setState(() {
      _ponto = 0;
      cartas.shuffle();
      for (var i = 0; i < cartas.length; i++) {
        cartas[i].visivel = false;
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

  void _escondeCartas(List<Carta> value) {
    Timer(Duration(seconds: 2), () {
      for (var i = 0; i < value.length; i++) {
        setState(() {
          value[i].visivel = false;
        });
      }
    });
  }
}
