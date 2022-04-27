import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_management_bloc/constants/constants.dart';
import 'package:student_management_bloc/db/db_functions.dart';
import 'package:student_management_bloc/db/model/student_db.dart';
import 'package:student_management_bloc/logic/icon_cubit/icon_cubit_cubit.dart';
import 'package:student_management_bloc/logic/search_bloc/search_bloc_bloc.dart';
import 'package:student_management_bloc/logic/student_crud_cubit/student_crud_cubit.dart';

import 'presentation/screens/all_screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(StudentDBAdapter());
  await Hive.openBox<StudentDB>(kStudentBox);
  runApp(
    MyApp(
      searchBloc: SearchBlocBloc(),
    ),
  );
}

bool randomNumGenerator(int randomNum) {
  Random random = Random();
  randomNum = random.nextInt(2);
  if (randomNum == 1) {
    return true;
  } else {
    return false;
  }
}

class MyApp extends StatelessWidget {
  final SearchBlocBloc searchBloc;
  const MyApp({Key? key, required this.searchBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => StudentCrudCubit(
            list: DbFunctions.getStudentsList(),
            searchBloc: searchBloc,
          ),
        ),
        BlocProvider(create: (context) => searchBloc),
        BlocProvider(create: (context) => IconCubitCubit()),
      ],
      child: MaterialApp(
        home: HomePage(),
        debugShowCheckedModeBanner: false,
        title: 'Student Manage With BLoC',
        theme: randomNumGenerator(1) ? ThemeData.dark() : ThemeData.light(),
      ),
    );
  }
}
