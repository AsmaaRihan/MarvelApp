import 'dart:async';
import 'dart:convert';

import '/models/characters.dart';
import '/repo/CharactersRepo.dart';
import '/service_provide.dart';

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
        superhero = await CharacterData()
            .getAllCharactersId(path: event.path, type: "Character");
        yield GetAllCharactersState(superhero: superhero);
      } else if (event.searchWay == 'ById') {
        superhero = await CharacterData().getAllCharactersId(
            path: '${event.path}${event.searchedText}', type: "Character");
        yield GetCharactersByNameState(superhero: superhero);
      } else if (event.searchWay == 'BySearchTerm') {
        superhero = await CharacterData().getAllCharactersId(
            path: '${event.path}${event.searchedText}', type: "Character");
        yield GetCharactersBySearchTermState(superhero: superhero);
      }
    } else if (event is GetComic) {
      superhero = await CharacterData().getAllCharactersId(
          path: '${event.path}${event.searchedText}', type: "Character");
      print("GetComic: " + event.path);
      yield ShowComicState();
    }
  }
}
