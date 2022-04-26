part of 'search_bloc_bloc.dart';

@immutable
abstract class SearchBlocEvent {
  const SearchBlocEvent();
}

class EnterInputState extends SearchBlocEvent {
  final String searchInput;
  const EnterInputState({required this.searchInput});
}

class ClearInputState extends SearchBlocEvent {}
