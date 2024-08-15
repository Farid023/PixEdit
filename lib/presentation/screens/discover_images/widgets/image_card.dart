import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pixedit/core/extensions/context_extensions.dart';

import '../../../../core/constants/app_radiuses.dart';
import '../../../../core/navigation/pages.dart';
import '../../../../domain/models/images.dart';
import 'image_card_shimmer.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({super.key, required this.item});

  final Photo item;

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      borderRadius: AppRadiuses.a10,
      child: SizedBox(
        width: context.fullWidth * 0.40,
        height: context.fullWidth * 0.40,
        child: InkWell(
          onTap: () {
            context.to(Pages.imageViewScreen(item: item));
            log(item.id.toString());
          },
          child: CachedNetworkImage(
            imageUrl: "${item.src?.medium}",
            fit: BoxFit.cover,
            progressIndicatorBuilder: (context, url, downloadProgress) {
              return const ImageCardShimmer();
            },
          ),
        ),
      ),
    );
  }
}
