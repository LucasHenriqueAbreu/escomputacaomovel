import 'package:flutter/material.dart';

class Carta {
  int id;
  int grupo;
  bool visivel;
  Color cor;
  String imagem;

  Carta({this.id, this.grupo, this.visivel = false, this.cor, this.imagem});
}
