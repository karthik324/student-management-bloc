import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_management_bloc/constants/constants.dart';
import 'package:student_management_bloc/db/db_functions.dart';
import 'package:student_management_bloc/db/model/student_db.dart';
import 'package:student_management_bloc/logic/student_crud_cubit/student_crud_cubit.dart';

class StudentEditPage extends StatefulWidget {
  final box = Hive.box<StudentDB>(kStudentBox);
  final List<StudentDB> list;
  final int index;
  StudentEditPage({Key? key, required this.index, required this.list})
      : super(key: key);

  @override
  State<StudentEditPage> createState() => _StudentEditPageState();
}

class _StudentEditPageState extends State<StudentEditPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController placeController = TextEditingController();

  XFile? image;
  String? imagePath;
  late StudentDB student;

  void details() {
    student = DbFunctions.getStudent(widget.index);
    nameController.text = student.name;
    ageController.text = student.age.toString();
    placeController.text = student.place;
    imagePath = student.imagePath;
  }

  @override
  void initState() {
    details();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit ${student.name}'),
        elevation: 10,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (imagePath != null)
                ClipRRect(
                  child: Image.file(
                    File(imagePath!),
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
              kVerticalSpace,
              TextField(
                controller: nameController,
                style: const TextStyle(fontSize: 16),
                decoration: const InputDecoration(
                  labelText: 'Name',
                  enabledBorder: OutlineInputBorder(),
                ),
              ),
              kVerticalSpace,
              TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 16),
                decoration: const InputDecoration(
                  labelText: 'Age',
                  enabledBorder: OutlineInputBorder(),
                ),
              ),
              kVerticalSpace,
              TextField(
                controller: placeController,
                style: const TextStyle(fontSize: 16),
                decoration: const InputDecoration(
                  labelText: 'Place',
                  enabledBorder: OutlineInputBorder(),
                ),
              ),
              kVerticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => getImage(source: ImageSource.gallery),
                    child: const Text('Select New Image'),
                  ),
                  ElevatedButton(
                    onPressed: () => getImage(source: ImageSource.camera),
                    child: const Text('Take New Image'),
                  ),
                ],
              ),
              kVerticalSpace,
              ElevatedButton(
                onPressed: () {
                  StudentDB student = StudentDB(
                    name: nameController.text,
                    age: int.parse(ageController.text),
                    place: placeController.text,
                    imagePath: imagePath,
                  );
                  BlocProvider.of<StudentCrudCubit>(context)
                      .editStudentListUpdated(
                    DbFunctions.getBox(),
                    student,
                    widget.index,
                  );
                  Navigator.pop(context);
                },
                child: const Text('Submit Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getImage({required ImageSource source}) async {
    image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      setState(() {
        imagePath = (image!.path);
      });
    } else {
      return null;
    }
  }
}
