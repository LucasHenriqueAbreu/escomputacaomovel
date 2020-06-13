import 'package:flutter/material.dart';

class Carta {
  int id;
  int grupo;
  bool visivel;
  Color cor;

  Carta({this.id, this.grupo, this.visivel = false, this.cor});
}
