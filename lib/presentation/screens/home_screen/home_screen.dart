import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_management_bloc/constants/constants.dart';
import 'package:student_management_bloc/db/db_functions.dart';
import 'package:student_management_bloc/db/model/student_db.dart';
import 'package:student_management_bloc/logic/icon_cubit/icon_cubit_cubit.dart';
import 'package:student_management_bloc/logic/search_bloc/search_bloc_bloc.dart';
import 'package:student_management_bloc/logic/student_crud_cubit/student_crud_cubit.dart';
import 'package:student_management_bloc/presentation/screens/all_screens.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  IconData? myIcon;
  Widget customSearchBar = const Text('Student Manage');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 60),
        child: BlocBuilder<IconCubitCubit, IconCubitState>(
          builder: (context, state) {
            myIcon = state.props[0] as IconData;
            return AppBar(
              title: customSearchBar,
              centerTitle: true,
              elevation: 10,
              actions: [
                IconButton(
                  onPressed: () {
                    context.read<IconCubitCubit>().changeIcon(myIcon!);
                    if (myIcon == Icons.search) {
                      customSearchBar = TextField(
                        // autofocus: true,
                        onChanged: (value) {
                          // print(value);
                          context
                              .read<SearchBlocBloc>()
                              .add(EnterInputState(searchInput: value));
                        },
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          hintText: 'Search here',
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      );
                    } else {
                      context.read<SearchBlocBloc>().add(ClearInputState());
                      customSearchBar = const Text('Student Manage');
                    }
                  },
                  icon: Icon(myIcon),
                ),
              ],
            );
          },
        ),
      ),
      body: BlocBuilder<StudentCrudCubit, StudentCrudState>(
        builder: (context, state) {
          if (state is AllStudentState) {
            if (state.studentsList.isEmpty) {
              return const Center(
                child: Text('List is empty add some students'),
              );
            } else {
              final List<StudentDB> datas = state.studentsList;
              final values = Hive.box<StudentDB>(kStudentBox).values.toList();
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 10,
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => StudentViewPage(
                              index: datas[index].key,
                            ),
                          ),
                        );
                      },
                      tileColor: Colors.lightGreen[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      title: Text(datas[index].name),
                      leading: datas[index].imagePath == null
                          ? CircleAvatar(
                              backgroundColor: Colors.green.shade100,
                              radius: 20,
                            )
                          : CircleAvatar(
                              child: ClipOval(
                                child: Image.file(
                                  File(datas[index].imagePath!),
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) => StudentEditPage(
                                    index: datas[index].key,
                                    list: values,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Are you sure? '),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('No'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          int deleteKey = datas[index].key;
                                          context
                                              .read<StudentCrudCubit>()
                                              .deleteStudentListUpdated(
                                                DbFunctions.getBox(),
                                                deleteKey,
                                              );
                                          context
                                              .read<SearchBlocBloc>()
                                              .add(ClearInputState());
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Yes'),
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
                separatorBuilder: (context, index) {
                  return SizedBox.fromSize(
                    size: const Size(0, 4),
                  );
                },
                itemCount: datas.length,
              );
            }
          } else if (state is NoResultsState) {
            return const Center(
              child: Text('No Results found'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => const StudentAddPage(),
            ),
          );
        },
      ),
    );
  }
}
