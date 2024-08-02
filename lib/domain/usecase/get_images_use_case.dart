import 'package:photo_editor/domain/models/images.dart';

import '../repository/images_repository.dart';

class GetImagesUseCase {
  GetImagesUseCase({required this.imagesRepository});

  final ImagesRepository imagesRepository;

  Future<Images> execute({int? page, int? perPage,String? pathUrl}) {
    return imagesRepository.getImages(page: page, perPage: perPage,pathUrl: pathUrl);
  }
}
