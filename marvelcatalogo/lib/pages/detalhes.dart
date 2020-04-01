import 'package:flutter/material.dart';
import 'package:marvelcatalogo/models/models.dart';
import 'package:marvelcatalogo/shared/image_aux.dart';

class Detalhes extends StatelessWidget {
  final Character character;

  const Detalhes({Key key, @required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxlsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              snap: false,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(character.name),
                background: ImageAux(
                  url:
                      '${character.thumbnail.path}.${character.thumbnail.extension}',
                ),
              ),
            )
          ];
        },
        body: Text('Teste'),
      ),
    );
  }
}
