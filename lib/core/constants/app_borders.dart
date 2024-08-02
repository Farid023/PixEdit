import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radiuses.dart';

class AppBorders {
  AppBorders._();

  static const addNewImageCardBorder = RoundedRectangleBorder(
    borderRadius: AppRadiuses.a10,
    side: BorderSide(color: AppColors.black, width: 1),
  );
}
