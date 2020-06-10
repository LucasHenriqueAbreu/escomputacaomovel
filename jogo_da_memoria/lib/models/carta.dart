import 'package:flutter/material.dart';

class Carta {
  int id;
  int grupo;
  bool selecionada;
  Color cor;

  Carta({this.id, this.grupo, this.selecionada = false, this.cor});
}
