import 'dart:async';
import 'dart:convert';

import 'package:Marvel_App/models/characters.dart';
import 'package:Marvel_App/service_provide.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

part 'marvel_event.dart';
part 'marvel_state.dart';

class MarvelBloc extends Bloc<MarvelEvent, MarvelState> {
  var hash, timeStamp = DateTime.now();
  String urlFinal;
  Data superhero;
  var baseurl = 'http://gateway.marvel.com/v1/public/';

  MarvelBloc() : super(MarvelInitial());

  @override
  Stream<MarvelState> mapEventToState(
    MarvelEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is GetCharacters) {
      if (event.searchWay == 'ByCharacters') {
        superhero = await getAllCharactersId(event.path, "Character");
        yield GetAllCharactersState(superhero: superhero);
      } else if (event.searchWay == 'ById') {
        superhero = await getAllCharactersId(
            '${event.path}${event.searchedText}', "Character");
        yield GetCharactersByNameState(superhero: superhero);
      } else if (event.searchWay == 'BySearchTerm') {
        superhero = await getAllCharactersId(
            '${event.path}${event.searchedText}', "Character");
        yield GetCharactersBySearchTermState(superhero: superhero);
      }
    } else if (event is GetComic) {
      superhero = await getAllCharactersId(
          '${event.path}${event.searchedText}', "Character");
      print("GetComic: " + event.path);
      yield ShowComicState();
    }
  }

  Future getAllCharactersId(String path, String type) async {
    String urlFinal = generateUrl(path, type);

    // characters?name=Avengers  ByName
    //characters?name=${searchTerm}  BySearchTerm

    final response = await http.get(urlFinal);
    return parseResonse(response);
  }

  generateUrl(String path, String type) {
    ///// Getting Hash
    String input = timeStamp.toIso8601String() +
        ServiceProvider.privateKey +
        ServiceProvider.publicKey;
    hash = md5.convert(utf8.encode(input)).toString();

    ///////////// geting Url
    if (type == 'Character') {
      urlFinal =
          "$baseurl$path&apikey=${ServiceProvider.publicKey}&hash=$hash&ts=${timeStamp.toIso8601String()}";
      print("urlFinal Character: " + urlFinal);
    } else /*if (type == 'Comic') */ {
      urlFinal =
          "$path&apikey=${ServiceProvider.publicKey}&hash=$hash&ts=${timeStamp.toIso8601String()}";
      print("urlFinal Comic: " + urlFinal);
    }
    return urlFinal;
  }

  Future parseResonse(http.Response response) async {
    final responseString = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return Characterss.fromJson(responseString).data;
    } else {
      throw Exception('failed to load Superheros');
    }
  }
}
