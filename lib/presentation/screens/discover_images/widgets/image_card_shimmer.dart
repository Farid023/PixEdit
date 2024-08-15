
import 'package:PixEdit/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ImageCardShimmer extends StatelessWidget {
  const ImageCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
        width: context.fullWidth * 0.40,
        height: context.fullWidth * 0.40,
        color: Colors.black12,
      ),
    );
  }
}
