import 'package:flutter/material.dart';

class Home extends StatelessWidget {


  List<Widget> _criaLogosFlutter() {
    return  <Widget>[
      FlutterLogo(
        size: 100.0,
        colors: Colors.green,
      ),
      FlutterLogo(
        size: 100.0,
        colors: Colors.yellow,
      ),
      FlutterLogo(
        size: 100.0,
        colors: Colors.red,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demonstração'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget> [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _criaLogosFlutter(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _criaLogosFlutter(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _criaLogosFlutter(),
            )
          ],
        ),
      ),
    );
  }
}
