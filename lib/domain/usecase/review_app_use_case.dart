import '../repository/images_local_repository.dart';

class ReviewAppUseCase {
  ReviewAppUseCase(this.imagesLocalRepository);

  final ImagesLocalRepository imagesLocalRepository;

  Future<bool> execute() {
    return imagesLocalRepository.showRating();
  }
}
