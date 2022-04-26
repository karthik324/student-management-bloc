part of 'search_bloc_bloc.dart';

@immutable
abstract class SearchBlocState {
  const SearchBlocState();
}

class SearchResult extends SearchBlocState {
  final List<StudentDB> studentList;
  const SearchResult({required this.studentList});
}
