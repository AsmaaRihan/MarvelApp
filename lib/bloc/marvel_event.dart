part of 'marvel_bloc.dart';

@immutable
abstract class MarvelEvent {}

class GetCharacters extends MarvelEvent {
  String path, searchWay, searchedText;

  GetCharacters(
      {@required this.path, @required this.searchWay, this.searchedText});
}

class GetComic extends MarvelEvent {
  String path, searchWay, searchedText;

  GetComic({@required this.path, @required this.searchWay, this.searchedText});
}
