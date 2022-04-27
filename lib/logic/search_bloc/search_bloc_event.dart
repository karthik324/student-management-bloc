part of 'search_bloc_bloc.dart';

@immutable
abstract class SearchBlocEvent {
  const SearchBlocEvent();
}

class EnterInputEvent extends SearchBlocEvent {
  final String searchInput;
  const EnterInputEvent({required this.searchInput});
}

class ClearInputEvent extends SearchBlocEvent {}
