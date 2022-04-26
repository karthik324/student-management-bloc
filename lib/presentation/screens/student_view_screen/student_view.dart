import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_management_bloc/constants/constants.dart';
import 'package:student_management_bloc/db/db_functions.dart';
import 'package:student_management_bloc/db/model/student_db.dart';

class StudentViewPage extends StatelessWidget {
  final int index;
  // final List<StudentDB> list;
  const StudentViewPage({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StudentDB student = DbFunctions.getStudent(index);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student View'),
        centerTitle: true,
        elevation: 10,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.green.shade100,
              child: ClipOval(
                child: Image.file(
                  File(student.imagePath!),
                  width: 160,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            kVerticalSpace,
            Text(
              student.name,
              style: const TextStyle(
                color: Colors.lightGreen,
                fontSize: 35,
              ),
            ),
            kVerticalSpace,
            Text(
              student.place,
              style: const TextStyle(
                color: Colors.lightGreen,
                fontSize: 25,
              ),
            ),
            kVerticalSpace,
            Text(
              student.age.toString(),
              style: const TextStyle(
                color: Colors.lightGreen,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
