import 'dart:async';

import 'package:Marvel_App/repo/CharactersRepo.dart';

import '/models/characters.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'searchbyid_event.dart';
import 'searchbyid_state.dart';

class SearchbyidBloc extends Bloc<SearchbyidEvent, SearchbyidState> {
  SearchbyidBloc() : super(SearchbyidInitial());
  Data superhero;
  @override
  Stream<SearchbyidState> mapEventToState(
    SearchbyidEvent event,
  ) async* {
    if (event is SearchById) {
      superhero = await CharacterData().getAllCharactersId(
          path: '${event.path}${event.searchedText}', type: "Character");
      yield GetCharactersByNameState(superhero: superhero);
    }
  }
}
