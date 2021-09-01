part of 'marvel_bloc.dart';

@immutable
abstract class MarvelState {}

class MarvelInitial extends MarvelState {
  Data superhero;
  MarvelInitial({this.superhero});
}

class GetCharactersItemsState extends MarvelState {}

// ignore: must_be_immutable
class GetAllCharactersState extends MarvelState {
  Data superhero;
  GetAllCharactersState({@required this.superhero});
}

//////taken
class GetCharactersByNameState extends MarvelState {
  Data superhero;
  GetCharactersByNameState({this.superhero});
}

class GetCharactersBySearchTermState extends MarvelState {
  Data superhero;
  GetCharactersBySearchTermState({this.superhero});
}

class ShowComicState extends MarvelState {}
