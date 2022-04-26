import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_management_bloc/constants/constants.dart';
import 'package:student_management_bloc/db/db_functions.dart';
import 'package:student_management_bloc/db/model/student_db.dart';
import 'package:student_management_bloc/logic/student_crud_cubit/student_crud_cubit.dart';

class StudentAddPage extends StatefulWidget {
  const StudentAddPage({Key? key}) : super(key: key);

  @override
  State<StudentAddPage> createState() => _StudentAddPageState();
}

class _StudentAddPageState extends State<StudentAddPage> {
  final box = Hive.box<StudentDB>(kStudentBox);

  final TextEditingController nameController = TextEditingController();

  final TextEditingController ageController = TextEditingController();

  final TextEditingController placeController = TextEditingController();

  XFile? image;

  String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        centerTitle: true,
        title: const Text('Add Student'),
        actions: [
          IconButton(
            onPressed: () {
              StudentDB student = StudentDB(
                name: nameController.text,
                age: int.parse(ageController.text),
                place: placeController.text,
                imagePath: imagePath,
              );
              BlocProvider.of<StudentCrudCubit>(context)
                  .addStudentListUpdated(DbFunctions.getBox(), student);

              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.save,
              color: Colors.blue,
            ),
            iconSize: 24,
            tooltip: 'Save',
          ),
        ],
      ),
      body: BlocBuilder<StudentCrudCubit, StudentCrudState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
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
                ElevatedButton(
                  onPressed: () {
                    getImage(source: ImageSource.gallery);
                    // print(state);
                  },
                  child: const Text('Select Image'),
                ),
                ElevatedButton(
                  onPressed: () => getImage(source: ImageSource.camera),
                  child: const Text('Take an Image'),
                ),
                kVerticalSpace,
                TextField(
                  controller: nameController,
                  style: const TextStyle(fontSize: 16),
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                ),
                kVerticalSpace,
                TextField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 16),
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    labelText: 'Age',
                  ),
                ),
                kVerticalSpace,
                TextField(
                  controller: placeController,
                  style: const TextStyle(fontSize: 16),
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    labelText: 'Place',
                  ),
                ),
                kVerticalSpace,
              ],
            ),
          );
        },
      ),
    );
  }

  getImage({required ImageSource source}) async {
    image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      imagePath = image!.path;
      setState(() {});
    } else {
      return null;
    }
  }
}
