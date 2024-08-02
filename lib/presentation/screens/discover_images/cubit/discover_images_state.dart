part of 'discover_images_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {
  final List<Photo>? currentPhotos;
  final bool isFirstPage;

  HomeLoading(this.currentPhotos, {this.isFirstPage = false});
}

final class HomeSuccess extends HomeState {
  final List<Photo>? photos;

  HomeSuccess({required this.photos});
}

final class HomeFailure extends HomeState {
  HomeFailure({this.message});

  final String? message;
}
