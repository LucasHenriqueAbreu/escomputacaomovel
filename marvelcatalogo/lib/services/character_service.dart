import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:marvelcatalogo/consts/consts.dart';
import 'package:marvelcatalogo/models/character_response.dart';
import 'package:marvelcatalogo/models/models.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:convert/convert.dart';

class CharacterService {
  final url = ConstsAPI.MARVEL_API_URL + '/v1/public/characters';
  final itensPorPag = 100;
  final timestamp = DateTime.now().millisecondsSinceEpoch.toString();

  Future<List<Character>> getCharacterList() async {
    final hash = generateMd5(
        timestamp + ConstsAPI.PRIVATE_API_KEY + ConstsAPI.PUBLIC_API_KEY);

    try {
      int offset = 0;
      Map<String, String> queryParameters = {
        'apikey': ConstsAPI.PUBLIC_API_KEY,
        'hash': hash,
        'ts': timestamp,
        'limit': itensPorPag.toString(),
        'offset': offset.toString()
      };
      Response response = await Dio().get(
        url,
        queryParameters: queryParameters,
      );

      final json = jsonDecode(response.toString());
      CharacterDataWrapper characterDataWrapper =
          CharacterDataWrapper.fromJson(json);
      return characterDataWrapper.data.characters;
    } catch (e) {
      print(e);
    }
  }

  generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }
}
