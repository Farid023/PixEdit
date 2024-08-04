part of 'gallery_cubit.dart';

@immutable
sealed class GalleryState {}

final class GalleryInitial extends GalleryState {}

final class GalleryLoading extends GalleryState {
  // final List<Photo>? currentPhotos;
  // final bool isFirstPage;

 // GalleryLoading(this.currentPhotos, {this.isFirstPage = false});
}

final class GallerySuccess extends GalleryState {
  final List<String>? photos;


  GallerySuccess({required this.photos});
}

final class GalleryFailure extends GalleryState {
  GalleryFailure({this.message});

  final String? message;
}
