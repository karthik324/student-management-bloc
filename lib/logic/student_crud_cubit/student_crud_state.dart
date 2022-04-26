// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'student_crud_cubit.dart';

@immutable
abstract class StudentCrudState extends Equatable {}

class StudentCrudCubitInitial extends StudentCrudState {
  @override
  List<Object?> get props => [];
}

class AllStudentState extends StudentCrudState {
  final List<StudentDB> studentsList;
  AllStudentState({required this.studentsList});

  @override
  List<Object?> get props => [studentsList];
}

class AddStudentState extends StudentCrudState {
  @override
  List<Object?> get props => [];
}

class EditStudentState extends StudentCrudState {
  @override
  List<Object?> get props => [];
}

class DeleteStudentState extends StudentCrudState {
  @override
  List<Object?> get props => [];
}

class ImageUpdateState extends StudentCrudState {
  final List<StudentDB> studentsList;
  final String? image;
  ImageUpdateState({required this.studentsList, this.image});
  @override
  List<Object?> get props => [studentsList];
}

class NoResultsState extends StudentCrudState {
  @override
  List<Object?> get props => [];
}
