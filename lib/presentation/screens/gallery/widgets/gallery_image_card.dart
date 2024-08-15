import 'dart:io';

import 'package:PixEdit/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_radiuses.dart';
import '../../../../core/navigation/pages.dart';
import '../../discover_images/widgets/image_card_shimmer.dart';

class GalleryImageCard extends StatelessWidget {
  const GalleryImageCard({
    super.key,
    required this.imagePath,
  });

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      borderRadius: AppRadiuses.a10,
      child: InkWell(
        onTap: () {
          context.to(Pages.imageViewScreen(imagePath: imagePath));
        },
        child: Image.file(
          File(imagePath),
          fit: BoxFit.cover,
          filterQuality: FilterQuality.low,
          frameBuilder: (BuildContext context, Widget child, int? frame, bool? wasSynchronouslyLoaded) {
            if(frame == null){
              return const ImageCardShimmer();
            } else {
              return child;
            }
          },
        ),
      ),
    );
  }
}
