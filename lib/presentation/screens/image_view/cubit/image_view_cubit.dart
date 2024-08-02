import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_editor/domain/usecase/get_u_int8_list_from_url_use_case.dart';
import 'package:photo_editor/domain/usecase/save_to_local_db_use_case.dart';
import 'package:photo_editor/domain/usecase/share_image_use_case.dart';

part 'image_view_state.dart';

class ImageViewCubit extends Cubit<ImageViewState> {
  ImageViewCubit(this._saveToLocalDbUseCase, this._getUInt8ListFromUrlUseCase,
      this._shareImageUseCase)
      : super(ImageViewInitial());

  final SaveToLocalDbUseCase _saveToLocalDbUseCase;
  final GetUInt8ListFromUrlUseCase _getUInt8ListFromUrlUseCase;
  final ShareImageUseCase _shareImageUseCase;

  Uint8List? imageBytes;

  Future<void> saveToLocalDB(
      {required Uint8List? imageBytes, required String? imageUrl}) async {
    try {
      emit(ImageViewLoading());
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
        emit(ImageViewFailure(message: "Image is null"));
      }
    } catch (e) {
      emit(ImageViewFailure(message: "Failed to save image: ${e.toString()}"));
      throw Exception(e);
    }
  }

    Future<void> shareImage({required Uint8List imageBytes}) async{
    try {
      emit(ImageViewLoading());
     final share = await _shareImageUseCase.execute(imageBytes: imageBytes);
      emit(ImageViewSuccess());
      //return
    } catch (e) {
      log("$e");
      emit(ImageViewFailure(message: e.toString()));

    }
  }

  Future<Uint8List?> getBytesFromUrl(String imageUrl) async {
    return await _getUInt8ListFromUrlUseCase.execute(imageUrl: imageUrl);
  }

  Future<void> saveImageBytes({Uint8List? bytes}) async {
    imageBytes = bytes;
    log("imagebytes : $imageBytes");
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
