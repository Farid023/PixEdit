import 'dart:typed_data';

import 'package:photo_editor/domain/repository/images_repository.dart';

class GetUInt8ListFromUrlUseCase {
  GetUInt8ListFromUrlUseCase(this._imagesRepository);

  final ImagesRepository _imagesRepository;


  Future<Uint8List?> execute({required String imageUrl}){
    return _imagesRepository.getUint8ListFromUrl(imageUrl: imageUrl);
  }
}
