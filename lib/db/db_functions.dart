import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_management_bloc/constants/constants.dart';
import 'package:student_management_bloc/db/model/student_db.dart';

class DbFunctions {
  static Box<StudentDB> getBox() {
    final box = Hive.box<StudentDB>(kStudentBox);
    return box;
  }

  static List<StudentDB> getStudentsList() {
    final List<StudentDB> studentsList =
        Hive.box<StudentDB>(kStudentBox).values.toList();
    return studentsList;
  }

  static void addStudent(StudentDB student) {
    Hive.box<StudentDB>(kStudentBox).add(student);
  }

  static StudentDB getStudent(int key) {
    StudentDB student = Hive.box<StudentDB>(kStudentBox).get(key)!;
    return student;
  }

  static int updateStudent(int key, StudentDB student) {
    Hive.box<StudentDB>(kStudentBox).put(key, student);
    return key;
  }

  static int deleteStudent(int key) {
    Hive.box<StudentDB>(kStudentBox).delete(key);
    return key;
  }
}
