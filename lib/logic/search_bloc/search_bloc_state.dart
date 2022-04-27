part of 'search_bloc_bloc.dart';

@immutable
abstract class SearchBlocState {
  const SearchBlocState();
}

class SearchResultState extends SearchBlocState {
  final List<StudentDB> studentList;
  const SearchResultState({required this.studentList});
}
