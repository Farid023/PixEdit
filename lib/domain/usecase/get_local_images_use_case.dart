import 'dart:typed_data';

import 'package:photo_editor/domain/repository/images_local_repository.dart';

class GetLocalImagesUseCase {
  GetLocalImagesUseCase({required this.imagesLocalRepository});

  final ImagesLocalRepository imagesLocalRepository;


  Future<List<String>?> execute(){
    return imagesLocalRepository.getLocalImages();
  }
}
