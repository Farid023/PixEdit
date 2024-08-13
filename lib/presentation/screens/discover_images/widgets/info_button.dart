import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_editor/core/extensions/context_extensions.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_path.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../main.dart';

class InfoButton extends StatelessWidget {
  const InfoButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showAdaptiveDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              alignment: Alignment.topRight,
              insetPadding: const EdgeInsets.symmetric(
                  horizontal: 8, vertical: kToolbarHeight),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    AppStrings.photosProvidedBy,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        log("button clicked");
                        launchUrlAddress(
                            Uri.parse("https://www.pexels.com"), false);
                        context.back();
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(AppPath.pexels),
                          const Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              AppStrings.pexels,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: AppColors.green,
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            );
          },
        );
      },
      icon: const Icon(
        Icons.info_outline,
        color: AppColors.black,
      ),
    );
  }
}
