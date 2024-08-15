import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixedit/core/extensions/context_extensions.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_paddings.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/navigation/pages.dart';
import '../../../domain/models/images.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_network_image.dart';
import '../../widgets/loading_indicator_circular.dart';
import 'cubit/image_view_cubit.dart';

class ImageViewScreen extends StatelessWidget {
  const ImageViewScreen(
      {super.key, this.item, this.imageBytes, this.imagePath});

  final Photo? item;
  final Uint8List? imageBytes;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ImageViewCubit>();
    final imageUrl = item?.src?.original;
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.image),
        actions: [
          IconButton(
              onPressed: () async {
                await cubit.shareImage(
                    imageBytes: imageBytes,
                    imagePath: imagePath,
                    imageUrl: imageUrl);
              },
              icon: const Icon(Icons.share),
              color: AppColors.black)
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DecoratedBox(
            decoration: const BoxDecoration(color: Colors.black),
            child: Center(
                child: SizedBox(
              height: context.fullHeight * 0.6,
              child: imagePath != null
                  ? Image.file(File(imagePath!))
                  : imageBytes != null
                      ? Image.memory(imageBytes!, fit: BoxFit.fitWidth)
                      : (item != null
                          ? CustomNetworkImage(
                              errorListener: (error) async {
                                log("CustomNetworkImage: $error");
                                await cubit.setError("$error");
                              },
                              downloadListener: (progress) async {
                                if (progress != null) {
                                  await cubit.setLoading();
                                } else {
                                  await cubit.resetState();
                                }
                              },
                              imageUrl: imageUrl ?? "",
                              fit: BoxFit.fitWidth)
                          : const Center(
                              child: Text(AppStrings.noImageAvailable))),
            )),
          ),
          const SizedBox(height: 20),
          BlocConsumer<ImageViewCubit, ImageViewState>(
            builder: (context, state) {
              if (state is ImageViewFailure) {
                return const Padding(
                  padding: AppPaddings.a24,
                  child: Center(
                    child: Text(
                      AppStrings.errorText,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                );
              } else if (state is ImageViewLoading) {
                return const Padding(
                  padding: AppPaddings.a24,
                  child: LoadingIndicatorCircular(),
                );
              } else if (state is ImageViewSuccess ||
                  state is ImageSaveSuccess ||
                  imageBytes != null ||
                  imagePath != null) {
                return Column(
                  children: [
                    CustomButton(
                        onPressed: () {
                          context.to(Pages.editImageScreen(
                              item: item,
                              imageBytes: imageBytes,
                              imagePath: imagePath));
                        },
                        text: AppStrings.editImage),
                    CustomButton(
                        onPressed: () async {
                          await cubit.saveToLocalDB(
                              imageBytes: imageBytes, imageUrl: imageUrl);
                        },
                        text: AppStrings.saveToGallery),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
            listener: (BuildContext context, ImageViewState state) {
              if (state is ImageSaveSuccess) {
                showAdaptiveDialog(
                    context: context,
                    builder: (BuildContext _) {
                      return AlertDialog.adaptive(
                        title: const Text(AppStrings.successfullySaved),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        actions: [
                          TextButton(
                              onPressed: () {
                                context.back();
                              },
                              child: const Text(
                                "OK",
                                style: TextStyle(color: AppColors.black),
                              ))
                        ],
                      );
                    });
              }
            },
          ),
        ],
      ),
    );
  }
}
