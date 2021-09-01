import 'dart:convert';

import 'package:crypto/crypto.dart';

class Url {
  static const String publicKey = '291c8fbbdae87bfa2041fc40f9c15354';
  static const String privateKey = '1851560a77b659f8f4a7f2a94b4e852fbac25c96';
  var timeStamp = DateTime.now();
  var url = 'http://gateway.marvel.com/v1/public/';
  var hash;

  generateUrl(String path) {
    generateHash();
    String urlFinal =
        "$url$path?apikey=$publicKey&hash=$hash&ts=${timeStamp.toIso8601String()}";
    print("urlFinal: " + urlFinal);
    return urlFinal;
  }

  generateHash() {
    hash = generateMd5(timeStamp.toIso8601String() + privateKey + publicKey);
    print("HASH: " + hash);
  }

  generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }
}
