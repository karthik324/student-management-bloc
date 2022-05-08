import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:student_management_bloc/constants/constants.dart';
import 'package:student_management_bloc/db/db_functions.dart';
import 'package:student_management_bloc/db/model/student_db.dart';
import 'package:student_management_bloc/logic/search_bloc/search_bloc_bloc.dart';

part 'student_crud_state.dart';

class StudentCrudCubit extends Cubit<StudentCrudState> {
  final List<StudentDB> list;
  late StreamSubscription streamSubscription;
  final SearchBlocBloc searchBloc;
  final box = Hive.box<StudentDB>(kStudentBox);

  StudentCrudCubit({required this.list, required this.searchBloc})
      : super(StudentCrudCubitInitial()) {
    emit(AllStudentState(studentsList: list));
    streamSubscription = searchBloc.stream.listen((state) {
      if (state is SearchResultState) {
        if (state.studentList.isNotEmpty) {
          studentListUpdated(state.studentList);
        } else {
          emit(NoResultsState());
        }
      }
    });
  }

  void studentListUpdated(List<StudentDB> list) {
    emit(AllStudentState(studentsList: list));
  }

  void addStudentListUpdated(Box<StudentDB> box, StudentDB student) {
    DbFunctions.addStudent(student);
    emit(AllStudentState(studentsList: box.values.toList()));
  }

  void editStudentListUpdated(Box<StudentDB> box, StudentDB student, int key) {
    DbFunctions.updateStudent(key, student);
    emit(AllStudentState(studentsList: box.values.toList()));
  }

  void deleteStudentListUpdated(Box<StudentDB> box, int key) {
    DbFunctions.deleteStudent(key);
    emit(AllStudentState(studentsList: box.values.toList()));
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
