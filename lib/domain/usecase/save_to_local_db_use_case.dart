import 'dart:typed_data';


import '../repository/images_local_repository.dart';

class SaveToLocalDbUseCase {
  SaveToLocalDbUseCase({required this.imagesLocalRepository});

  final ImagesLocalRepository imagesLocalRepository;

  Future<void> execute(Uint8List imageBytes) {
    return imagesLocalRepository.saveImages(imageBytes);
  }
}
