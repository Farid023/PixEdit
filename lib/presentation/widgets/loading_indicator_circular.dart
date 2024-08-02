import 'package:flutter/material.dart';
import 'package:photo_editor/core/constants/app_paddings.dart';

class LoadingIndicatorCircular extends StatelessWidget {
  const LoadingIndicatorCircular({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: AppPaddings.a8,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
