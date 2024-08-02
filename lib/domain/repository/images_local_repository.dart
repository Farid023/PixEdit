import 'dart:typed_data';

abstract class ImagesLocalRepository {
  ImagesLocalRepository._();

  Future<void> saveImages(Uint8List imageBytes);

  Future<List<Uint8List>?> getLocalImages();

  Future<Uint8List?> pickImage();

  Future<void> shareImage({required Uint8List imageBytes});


}
