import '../repository/images_local_repository.dart';

class IsFirstTimeOpenUseCase {
  IsFirstTimeOpenUseCase(this.imagesLocalRepository);

  final ImagesLocalRepository imagesLocalRepository;

  Future<bool> execute() {
    return imagesLocalRepository.isFirstTimeOpen();
  }
}
