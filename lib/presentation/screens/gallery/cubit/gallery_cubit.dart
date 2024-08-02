import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_editor/domain/usecase/get_local_images_use_case.dart';
import 'package:photo_editor/domain/usecase/pick_image_use_case.dart';

part 'gallery_state.dart';

class GalleryCubit extends Cubit<GalleryState> {
  GalleryCubit(this._getLocalImagesUseCase, this._pickImageUseCase)
      : super(GalleryInitial());

  final GetLocalImagesUseCase _getLocalImagesUseCase;
  final PickImageUseCase _pickImageUseCase;

  Future<void> getLocalImages() async {
    try {
      emit(GalleryLoading());
      final images = await _getLocalImagesUseCase.execute();
      emit(GallerySuccess(photos: images));
    } catch (e) {
      emit(GalleryFailure(message: "Failed to load images"));
      throw Exception(e);
    }
  }

  Future<Uint8List?>? pickImage() async {
    try {
      return await _pickImageUseCase.execute();
    } catch (e) {
      log("$e");
      return null;
    }
  }
}
