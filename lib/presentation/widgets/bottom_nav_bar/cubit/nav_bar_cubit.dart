import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/navigation/pages.dart';



class NavBarCubit extends Cubit<int> {
  NavBarCubit() : super(0);

  void updateIndex(int index) {
    emit(index);
  }

  final List<Widget> bodyWidgets = <Widget>[Pages.discoverImages, Pages.gallery];
}
