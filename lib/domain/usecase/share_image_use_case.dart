import 'dart:typed_data';
import '../repository/images_local_repository.dart';

class ShareImageUseCase {
  final ImagesLocalRepository _imagesLocalRepository;

  ShareImageUseCase({required ImagesLocalRepository imagesLocalRepository})
      : _imagesLocalRepository = imagesLocalRepository;

  Future<void> execute({required Uint8List imageBytes}) async {
    return await _imagesLocalRepository.shareImage(imageBytes: imageBytes);
  }
}
