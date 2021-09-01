import '/models/characters.dart';

abstract class SearchbyidState {}

class SearchbyidInitial extends SearchbyidState {}

class GetCharactersByNameState extends SearchbyidState {
  Data superhero;
  GetCharactersByNameState({this.superhero});
}
