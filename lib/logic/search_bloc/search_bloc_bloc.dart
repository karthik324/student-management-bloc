import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:student_management_bloc/db/db_functions.dart';
import 'package:student_management_bloc/db/model/student_db.dart';

part 'search_bloc_event.dart';
part 'search_bloc_state.dart';

class SearchBlocBloc extends Bloc<SearchBlocEvent, SearchBlocState> {
  SearchBlocBloc()
      : super(SearchResultState(studentList: DbFunctions.getStudentsList())) {
    on<SearchBlocEvent>(
      (event, emit) {
        if (event is EnterInputEvent) {
          List<StudentDB> studentDatas = DbFunctions.getStudentsList()
              .where(
                (element) => element.name.toLowerCase().contains(
                      event.searchInput.toLowerCase(),
                    ),
              )
              .toList();
          emit(
            SearchResultState(studentList: studentDatas),
          );
        }
        if (event is ClearInputEvent) {
          emit(
            SearchResultState(
              studentList: DbFunctions.getStudentsList(),
            ),
          );
        }
      },
    );
  }
}
