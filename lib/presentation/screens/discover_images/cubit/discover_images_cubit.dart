import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/models/images.dart';
import '../../../../domain/usecase/get_images_use_case.dart';

part 'discover_images_state.dart';

class DiscoverImagesCubit extends Cubit<HomeState> {
  DiscoverImagesCubit(this._getImagesUseCase) : super(HomeInitial()) {
    controller.addListener(() {
      if (isEndOfPage) {
        log('Fetch next page');

        getImages(pathUrl: nextPageUrl);
      }
    });
  }

  final GetImagesUseCase _getImagesUseCase;

  final controller = ScrollController();

  int firstPage = 1;

  String? nextPageUrl;

  bool get isEndOfPage =>
      controller.position.pixels == controller.position.maxScrollExtent;

  Future<void> getImages({int? page, int? perPage, String? pathUrl}) async {
    try {
      if (state is HomeLoading) return;
      final currentState = state;

      List<Photo>? currentPhotos = [];
      if (currentState is HomeSuccess) {
        currentPhotos = currentState.photos;
      }

      emit(HomeLoading(currentPhotos, isFirstPage: firstPage == 1));

      final data = await _getImagesUseCase.execute(
          page: page, perPage: perPage, pathUrl: nextPageUrl);

      firstPage += 1;

      log("firstPage: $firstPage");
      nextPageUrl = data.nextPage;

      final imageList = (state as HomeLoading).currentPhotos;
      final List<Photo>? newImages = data.photos;
      imageList?.addAll(newImages ?? []);

      emit(HomeSuccess(photos: imageList));
    } catch (e) {
      emit(HomeFailure(message: "Failed to load images"));
      log("DiscoverImagesCubit $e");
      throw Exception(e);
    }
  }

  Future<void> update({int? page, int? perPage, String? pathUrl}) async {
    page = null;
    nextPageUrl = null;
    firstPage = 1;

    if (state is HomeSuccess) {
      final imageList = (state as HomeSuccess).photos;

      imageList?.clear();
    }

    return await getImages();
  }
}
