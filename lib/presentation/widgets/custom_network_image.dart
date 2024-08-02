import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:photo_editor/core/constants/app_path.dart';
import 'package:photo_editor/core/extensions/context_extensions.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../core/constants/app_colors.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.errorListener,
    this.downloadListener,
  });

  final String imageUrl;
  final BoxFit? fit;
  final void Function(Object)? errorListener;
  final void Function(double?)? downloadListener;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      errorListener: errorListener,
      errorWidget: (context, url, error) {
        return Center(
          child: SvgPicture.asset(AppPath.rip),
        );
      },
      progressIndicatorBuilder: (context, url, downloadProgress) {
        if (downloadListener != null) {
          downloadListener!(downloadProgress.progress);
        }
        return Skeletonizer(
          child: Container(
            width: context.fullWidth,
            height: context.fullHeight,
            color: AppColors.black,
          ),
        );
      },
    );
  }
}
