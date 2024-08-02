import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_editor/core/constants/app_strings.dart';
import 'package:photo_editor/core/extensions/context_extensions.dart';
import 'package:photo_editor/core/navigation/pages.dart';
import 'package:pro_image_editor/pro_image_editor.dart';

import '../../../domain/models/images.dart';
import '../image_view/cubit/image_view_cubit.dart';

class EditImageScreen extends StatelessWidget {
  const EditImageScreen({
    super.key,
    this.item,
    this.imageBytes,
  });

  final Photo? item;
  final Uint8List? imageBytes;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ImageViewCubit>();
    return Scaffold(
      body: imageBytes != null
          ? ProImageEditor.memory(
              imageBytes!,
              configs: const ProImageEditorConfigs(),
              callbacks: ProImageEditorCallbacks(
                onCloseEditor: () {
                  if (cubit.imageBytes != null) {
                    context.clearStackAndPush(
                        Pages.imageViewScreen(imageBytes: cubit.imageBytes));
                  } else {
                    cubit.imageBytes = null;
                    context.back();
                  }
                },
                onImageEditingComplete: (Uint8List bytes) async {
                  await cubit.saveImageBytes(bytes: bytes);
                },
              ),
            )
          : (item?.src?.original != null
              ? ProImageEditor.network(
                  "${item?.src?.original}",
                  callbacks: ProImageEditorCallbacks(
                    onCloseEditor: () {
                      if (cubit.imageBytes != null) {
                        context.clearStackAndPush(Pages.imageViewScreen(
                            imageBytes: cubit.imageBytes));
                      } else {
                        cubit.imageBytes = null;
                        context.back();
                      }
                    },
                    onImageEditingComplete: (Uint8List bytes) async {
                      await cubit.saveImageBytes(bytes: bytes);
                    },
                  ),
                )
              : const Center(child: Text(AppStrings.noImageAvailable))),
    );
  }
}
