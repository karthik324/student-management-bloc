// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive_flutter/hive_flutter.dart';
part 'student_db.g.dart';

@HiveType(typeId: 0)
class StudentDB extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int age;

  @HiveField(2)
  final String place;

  @HiveField(3)
  final String? imagePath;

  StudentDB({
    required this.name,
    required this.age,
    required this.place,
    this.imagePath,
  });
}
