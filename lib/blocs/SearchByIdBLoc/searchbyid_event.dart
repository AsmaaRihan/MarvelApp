abstract class SearchbyidEvent {}

class SearchById extends SearchbyidEvent {
  String path, searchedText;

  SearchById({this.path, this.searchedText});
}
