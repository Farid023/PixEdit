import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_editor/core/constants/app_strings.dart';
import 'package:photo_editor/presentation/widgets/bottom_nav_bar/cubit/nav_bar_cubit.dart';

import '../../widgets/bottom_nav_bar/bottom_navbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NavBarCubit>();
    return BlocBuilder<NavBarCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          appBar: AppBar(
            title: Text(currentIndex == 0
                ? AppStrings.discoverImages
                : currentIndex == 1
                    ? AppStrings.gallery
                    : ""),
          ),
          body: cubit.bodyWidgets[currentIndex],
          floatingActionButton: BottomNavbar(
            selectedIndex: context.watch<NavBarCubit>().state,
            onDestinationSelected: (int index) {
              context.read<NavBarCubit>().updateIndex(index);
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
