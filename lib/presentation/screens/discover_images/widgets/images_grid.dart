import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:PixEdit/core/constants/app_radiuses.dart';
import 'package:PixEdit/core/constants/app_strings.dart';
import 'package:PixEdit/presentation/widgets/loading_indicator_circular.dart';
import 'package:PixEdit/presentation/widgets/snackbars.dart';

import '../../../../domain/models/images.dart';
import '../../discover_images/cubit/discover_images_cubit.dart';
import 'image_card.dart';
import 'image_card_shimmer.dart';

class DiscoverImagesView extends StatelessWidget {
  const DiscoverImagesView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DiscoverImagesCubit>();
    return RefreshIndicator(
      onRefresh: () async {
        await cubit.update();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: BlocConsumer<DiscoverImagesCubit, HomeState>(
            listener: (_, state) {
              if (state is HomeFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  customSnackBar(
                      context: context,
                      message: state.message ?? "",
                      label: AppStrings.tryAgain,
                      onActionPressed: () {
                        context.read<DiscoverImagesCubit>().getImages();
                      }),
                );
              }
            },
            builder: (context, state) {
              bool isLoading = false;
              if (state is HomeLoading && state.isFirstPage) {
                log("pageNumber: ${state.isFirstPage}");
                isLoading = true;
                return const LoadingIndicatorCircular();
              }
              List<Photo> photos = [];

              if (state is HomeLoading) {
                photos = state.currentPhotos ?? [];
              } else if (state is HomeSuccess) {
                isLoading = false;
                photos = state.photos ?? [];
              }
              return GridView.builder(
                  itemCount: photos.length + 2,
                  padding: const EdgeInsets.all(8),
                  controller: cubit.controller,
                  physics: const AlwaysScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 6,
                  ),
                  itemBuilder: (_, index) {
                    if (index >= photos.length) {
                      return const Material(
                        clipBehavior: Clip.antiAlias,
                        borderRadius: AppRadiuses.a10,
                        child: ImageCardShimmer(),
                      );
                    }
                    final Photo item = photos[index];
                    return ImageCard(item: item);
                  });
            },
          )),
        ],
      ),
    );
  }
}
