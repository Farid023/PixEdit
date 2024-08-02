import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_editor/core/constants/app_radiuses.dart';
import 'package:photo_editor/core/extensions/context_extensions.dart';

import '../../../../core/navigation/pages.dart';

class GalleryImageCard extends StatelessWidget {
  const GalleryImageCard({
    super.key,
    required this.item,
  });

  final Uint8List item;

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      borderRadius: AppRadiuses.a10,
      child: InkWell(
        onTap: () {
          context.to(Pages.imageViewScreen(imageBytes: item));
        },
        child: Image(
          fit: BoxFit.cover,
          filterQuality: FilterQuality.low,
          image: ResizeImage(
              MemoryImage(
                item,
              ),
              width: 200,
              height: 200),
        ),
      ),
    );
  }
}
