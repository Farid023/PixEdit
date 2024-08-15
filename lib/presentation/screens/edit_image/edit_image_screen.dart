import 'dart:io';

import 'package:PixEdit/core/extensions/context_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_image_editor/pro_image_editor.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/navigation/pages.dart';
import '../../../domain/models/images.dart';
import '../image_view/cubit/image_view_cubit.dart';

class EditImageScreen extends StatelessWidget {
  const EditImageScreen({
    super.key,
    this.item,
    this.imageBytes,
    this.imagePath,
  });

  final Photo? item;
  final Uint8List? imageBytes;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ImageViewCubit>();
    return Scaffold(
      body: imagePath != null
          ? ProImageEditor.file(File(imagePath!),
              callbacks: _proImageEditorCallbacks(cubit, context))
          : imageBytes != null
              ? ProImageEditor.memory(
                  imageBytes!,
                  callbacks: _proImageEditorCallbacks(cubit, context),
                )
              : (item?.src?.original != null
                  ? ProImageEditor.network(
                      "${item?.src?.original}",
                      callbacks: _proImageEditorCallbacks(cubit, context),
                    )
                  : const Center(child: Text(AppStrings.noImageAvailable))),
    );
  }

  ProImageEditorCallbacks _proImageEditorCallbacks(
      ImageViewCubit cubit, BuildContext context) {
    return ProImageEditorCallbacks(
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
    );
  }
}
