part of 'image_view_cubit.dart';

@immutable
sealed class ImageViewState {}

final class ImageViewInitial extends ImageViewState {}

final class ImageViewLoading extends ImageViewState {}

final class ImageViewSuccess extends ImageViewState {}
final class ImageSaveLoading extends ImageViewState {}
final class ImageSaveSuccess extends ImageViewState {}

final class ImageSaveFailure extends ImageViewState {
  ImageSaveFailure({this.message});

  final String? message;
}

final class ImageViewFailure extends ImageViewState {
  ImageViewFailure({required this.message});

  final String? message;
}
