import 'package:flutter/material.dart';
import 'package:marvelcatalogo/services/character_service.dart';

class Home extends StatelessWidget {
  final characterService = CharacterService();
  

  @override
  Widget build(BuildContext context) {
    characterService.getCharacterList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Marvel catálogo'),
      ),
    );
  }
}
