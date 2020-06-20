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
    Carta(id: 1, grupo: 1, cor: Colors.amber, imagem: 'assets/ring.jpg'),
    Carta(id: 2, grupo: 1, cor: Colors.amber, imagem: 'assets/ring.jpg'),
    Carta(id: 3, grupo: 2, cor: Colors.blue, imagem: 'assets/ring.jpg'),
    Carta(id: 4, grupo: 2, cor: Colors.blue, imagem: 'assets/ring.jpg'),
    Carta(id: 5, grupo: 3, cor: Colors.orange, imagem: 'assets/ring.jpg'),
    Carta(id: 6, grupo: 3, cor: Colors.orange, imagem: 'assets/ring.jpg'),
    Carta(id: 7, grupo: 4, cor: Colors.brown, imagem: 'assets/ring.jpg'),
    Carta(id: 8, grupo: 4, cor: Colors.brown, imagem: 'assets/ring.jpg'),
    Carta(id: 9, grupo: 5, cor: Colors.teal, imagem: 'assets/ring.jpg'),
    Carta(id: 10, grupo: 5, cor: Colors.teal, imagem: 'assets/ring.jpg'),
    Carta(id: 11, grupo: 6, cor: Colors.cyan, imagem: 'assets/ring.jpg'),
    Carta(id: 12, grupo: 6, cor: Colors.cyan, imagem: 'assets/ring.jpg'),
    Carta(id: 13, grupo: 7, cor: Colors.black, imagem: 'assets/ring.jpg'),
    Carta(id: 14, grupo: 7, cor: Colors.black, imagem: 'assets/ring.jpg'),
    Carta(id: 15, grupo: 8, cor: Colors.green, imagem: 'assets/ring.jpg'),
    Carta(id: 16, grupo: 8, cor: Colors.green, imagem: 'assets/ring.jpg')
  ];

  Map<int, List<Carta>> cartasAgrupadasPorGrupo = Map<int, List<Carta>>();
  bool aguardandoCartasErradas = false;

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
      padding: EdgeInsets.all(5.0),
      crossAxisCount: 4,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: _criaListaCartas(),
    );
  }

  List<Widget> _criaListaCartas() {
    return cartas.map((Carta carta) => _criaCarta(carta)).toList();
  }

  Widget _criaCarta(Carta carta) {
    return GestureDetector(
      onTap: !aguardandoCartasErradas && !carta.visivel
          ? () => _mostraCarta(carta)
          : null,
      child: Card(
        child: AnimatedContainer(
          color: carta.visivel ? carta.cor : Colors.grey,
          duration: Duration(milliseconds: 400),
          child: _criaConteudoCarta(carta),
        ),
      ),
    );
  }

  Widget _criaConteudoCarta(Carta carta) {
    if (carta.visivel) {
      // return Text(
      //   carta.grupo.toString(),
      //   style: TextStyle(
      //     fontSize: 20,
      //     color: Colors.white,
      //   ),
      // );
      return Image.asset(
        carta.imagem,
        fit: BoxFit.cover,
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
    List<Carta> cartasVisiveis = _getCartasVisiveis();
    if (cartasVisiveis.length >= 2) {
      cartasAgrupadasPorGrupo = _getCartasAgrupadas(cartasVisiveis);
      List<Carta> cartasIncorretas =
          _getCartasIcorretas(cartasAgrupadasPorGrupo);
      if (cartasIncorretas.length >= 2) {
        _escondeCartas(cartasIncorretas);
      } else {
        _verificaVitoria();
      }
    }
  }

  void _escondeCartas(List<Carta> value) {
    setState(() {
      aguardandoCartasErradas = true;
    });
    Timer(Duration(seconds: 1), () {
      for (var i = 0; i < value.length; i++) {
        setState(() {
          value[i].visivel = false;
        });
      }

      setState(() {
        aguardandoCartasErradas = false;
      });
    });
  }

  List<Carta> _getCartasVisiveis() {
    return cartas.where((carta) => carta.visivel).toList();
  }

  Map<int, List<Carta>> _getCartasAgrupadas(List<Carta> cartas) {
    return groupBy(cartas, (Carta carta) => carta.grupo);
  }

  List<Carta> _getCartasIcorretas(
      Map<int, List<Carta>> cartasAgrupadasPorGrupo) {
    List<Carta> cartasIncorretas = [];
    cartasAgrupadasPorGrupo.forEach((key, value) {
      if (value.length < 2) {
        cartasIncorretas.add(value[0]);
      }
    });
    return cartasIncorretas;
  }

  void _verificaVitoria() {
    if (_getCartasVisiveis().length == 16) {
      print('Vitória!!!!');
    }
  }
}
