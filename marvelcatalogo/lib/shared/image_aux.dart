import 'package:flutter/material.dart';

class ImageAux extends StatelessWidget {
  final String url;

  const ImageAux({Key key, @required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white54),
      child: _getImageNetwork(url),
    );
  }

  Widget _getImageNetwork(String url) {
    try {
      if (url.isNotEmpty) {
        return FadeInImage.assetNetwork(
          placeholder: 'assets/images/placeholder.png',
          image: url,
          fit: BoxFit.cover,
        );
      }
    } catch (e) {
      return Image.asset('assets/images/placeholder.png');
    }
  }
}
