import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:student_management_bloc/db/db_functions.dart';
import 'package:student_management_bloc/db/model/student_db.dart';

part 'search_bloc_event.dart';
part 'search_bloc_state.dart';

class SearchBlocBloc extends Bloc<SearchBlocEvent, SearchBlocState> {
  SearchBlocBloc()
      : super(SearchResult(studentList: DbFunctions.getStudentsList())) {
    on<SearchBlocEvent>((event, emit) {
      if (event is EnterInputState) {
        List<StudentDB> studentDatas = DbFunctions.getStudentsList()
            .where((element) => element.name
                .toLowerCase()
                .contains(event.searchInput.toLowerCase()))
            .toList();
        emit(SearchResult(studentList: studentDatas));
      }
      if (event is ClearInputState) {
        emit(SearchResult(studentList: DbFunctions.getStudentsList()));
      }
    });
  }
}
