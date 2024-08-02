import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:photo_editor/core/constants/app_colors.dart';
import 'package:photo_editor/core/constants/app_path.dart';
import 'package:photo_editor/core/constants/app_radiuses.dart';
import 'package:photo_editor/core/constants/app_strings.dart';
import 'package:photo_editor/core/extensions/context_extensions.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({
    super.key,
    required this.selectedIndex,
    this.onDestinationSelected,
  });

  final int selectedIndex;
  final void Function(int)? onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
        decoration: const BoxDecoration(
          color: AppColors.black,
          borderRadius: AppRadiuses.a50,
        ),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            height: context.fullHeight * 0.08,
            backgroundColor: AppColors.transparent,
            indicatorColor: AppColors.transparent,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            elevation: 0.0,
            labelTextStyle: WidgetStateProperty.resolveWith(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.selected)) {
                  return const TextStyle(
                      color: AppColors.pink,
                      fontSize: 12,
                      fontWeight: FontWeight.bold);
                } else {
                  return const TextStyle(
                    color: AppColors.white,
                    fontSize: 12,
                  );
                }
              },
            ),
          ),
          child: NavigationBar(
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
            destinations: [
              NavigationDestination(
                icon: SvgPicture.asset(AppPath.discoverImages,
                    color: AppColors.white),
                selectedIcon: SvgPicture.asset(
                  AppPath.discoverImages,
                  color: AppColors.pink,
                ),
                label: AppStrings.discoverImages,
              ),
              NavigationDestination(
                icon: SvgPicture.asset(AppPath.gallery, color: AppColors.white),
                selectedIcon: SvgPicture.asset(
                  AppPath.gallery,
                  color: AppColors.pink,
                ),
                label: AppStrings.gallery,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
