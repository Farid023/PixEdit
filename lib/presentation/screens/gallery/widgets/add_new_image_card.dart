import 'package:PixEdit/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_borders.dart';
import '../../../../core/navigation/pages.dart';
import '../cubit/gallery_cubit.dart';

class AddNewImageCard extends StatelessWidget {
  const AddNewImageCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GalleryCubit>();
    return Material(
      clipBehavior: Clip.antiAlias,
      shape: AppBorders.addNewImageCardBorder,
      child: InkWell(
          onTap: () async {
            await cubit.pickImage()?.then((imageBytes) {
              if (imageBytes != null) {
                context.to(Pages.imageViewScreen(imageBytes: imageBytes));
              }
            });
          },
          child: const SizedBox(
              child: Icon(
            Icons.add,
            size: 56,
          ))),
    );
  }
}
