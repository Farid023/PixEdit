

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_paddings.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key, required this.onPressed, this.text,

  });


  final void Function() onPressed;
  final String? text;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.a8,
      child: ElevatedButton(
        onPressed: onPressed,
        style: const ButtonStyle(
          backgroundColor:
          WidgetStatePropertyAll(AppColors.black),
          fixedSize:
          WidgetStatePropertyAll(Size.fromHeight(60)),
        ),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text ?? "",
              style: const TextStyle(
                  fontSize: 18, color: AppColors.white),
            ),
          ],
        ),
      ),
    );
  }
}