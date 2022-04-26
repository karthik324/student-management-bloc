// import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'icon_cubit_state.dart';

class IconCubitCubit extends Cubit<IconCubitState> {
  IconCubitCubit() : super(const IconCubitChange(iconData: Icons.search));

  void changeIcon(IconData iconData) {
    if (iconData == Icons.search) {
      emit(const IconCubitChange(iconData: Icons.close));
    } else {
      emit(const IconCubitChange(iconData: Icons.search));
    }
  }
}
