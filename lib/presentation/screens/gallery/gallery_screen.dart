import 'dart:developer';

import 'package:pixedit/presentation/screens/gallery/widgets/add_new_image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_strings.dart';
import '../../widgets/loading_indicator_circular.dart';
import '../../widgets/snackbars.dart';
import 'cubit/gallery_cubit.dart';
import 'widgets/gallery_image_card.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GalleryCubit>();
    return RefreshIndicator(
      onRefresh: () async {
        await cubit.getLocalImages();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: BlocConsumer<GalleryCubit, GalleryState>(
            listener: (context, state) {
              // TODO: implement listener
              if (state is GalleryFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  customSnackBar(
                      context: context,
                      message: state.message ?? "",
                      label: AppStrings.tryAgain,
                      onActionPressed: () async {
                        await cubit.getLocalImages();
                      }),
                );
              }
            },
            builder: (context, state) {
              List<String> photos = [];
              if (state is GalleryLoading) {
                return const LoadingIndicatorCircular();
              }
              if (state is GallerySuccess) {
                photos = state.photos ?? [];
              }

              return GridView.builder(
                  itemCount: photos.length + 1,
                  padding: const EdgeInsets.all(8).copyWith(bottom: 100),
                  physics: const AlwaysScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 6,
                  ),
                  itemBuilder: (_, index) {
                    if (index == 0) {
                      return const AddNewImageCard();
                    }
                    final item = photos[index - 1];
                    log("item: $item");
                    return GalleryImageCard(imagePath: item);
                  });
            },
          )),
        ],
      ),
    );
  }
}
