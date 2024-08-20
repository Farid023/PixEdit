import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixedit/domain/usecase/is_first_time_open_use_case.dart';
import 'package:pixedit/domain/usecase/review_app_use_case.dart';

import '../../../../domain/usecase/get_u_int8_list_from_url_use_case.dart';
import '../../../../domain/usecase/save_to_local_db_use_case.dart';
import '../../../../domain/usecase/share_image_use_case.dart';

part 'image_view_state.dart';

class ImageViewCubit extends Cubit<ImageViewState> {
  ImageViewCubit(
      this._saveToLocalDbUseCase,
      this._getUInt8ListFromUrlUseCase,
      this._shareImageUseCase,
      this.isFirstTimeOpenUseCase,
      this.reviewAppUseCase)
      : super(ImageViewInitial());

  final SaveToLocalDbUseCase _saveToLocalDbUseCase;
  final GetUInt8ListFromUrlUseCase _getUInt8ListFromUrlUseCase;
  final ShareImageUseCase _shareImageUseCase;
  final IsFirstTimeOpenUseCase isFirstTimeOpenUseCase;
  final ReviewAppUseCase reviewAppUseCase;

  Uint8List? imageBytes;

  Future<void> saveToLocalDB(
      {required Uint8List? imageBytes, required String? imageUrl}) async {
    try {
      emit(ImageSaveLoading());
      Uint8List? loadedImageBytes = imageBytes;
      if (imageUrl != null) {
        loadedImageBytes =
            await _getUInt8ListFromUrlUseCase.execute(imageUrl: imageUrl);
        log("loadedImageBytes : $loadedImageBytes");
      }

      if (loadedImageBytes != null) {
        await _saveToLocalDbUseCase.execute(loadedImageBytes);
        emit(ImageSaveSuccess());
      } else {
        emit(ImageSaveFailure(message: "Image is null"));
      }
    } catch (e) {
      emit(ImageSaveFailure(message: "Failed to save image: ${e.toString()}"));
      throw Exception(e);
    }
  }

  Future<void> shareImage({
    String? imageUrl,
    Uint8List? imageBytes,
    String? imagePath,
  }) async {
    try {
      emit(ImageViewLoading());
      Uint8List? bytes;
      if (imageUrl != null) {
        bytes = await getBytesFromUrl(imageUrl);
      } else if (imageBytes != null) {
        bytes = imageBytes;
      } else if (imagePath != null) {
        bytes = await File(imagePath).readAsBytes();
      }

      if (bytes != null) {
        await _shareImageUseCase.execute(imageBytes: bytes);
        emit(ImageViewSuccess());
      } else {
        emit(ImageViewFailure(message: 'No image available to share.'));
      }
    } catch (e) {
      emit(ImageViewFailure(message: 'Failed to share image: ${e.toString()}'));
    }
  }

  void reviewApp() async {
    try {
      final isFirstTimeOpen = await isFirstTimeOpenUseCase.execute();

      log("isFirstTimeOpen: $isFirstTimeOpen");
      if (isFirstTimeOpen) {
        await reviewAppUseCase.execute();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Uint8List?> getBytesFromUrl(String imageUrl) async {
    return await _getUInt8ListFromUrlUseCase.execute(imageUrl: imageUrl);
  }

  Future<void> saveImageBytes({Uint8List? bytes}) async {
    imageBytes = bytes;
    log("imageBytes : $imageBytes");
  }

  Future<void> setError(String message) async {
    emit(ImageViewFailure(message: message));
  }

  Future<void> setLoading() async {
    emit(ImageViewLoading());
  }

  Future<void> resetState() async {
    emit(ImageViewSuccess());
  }
}
