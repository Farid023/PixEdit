import 'dart:typed_data';

import '../models/images.dart';

abstract class ImagesRepository {
  ImagesRepository._();

  Future<Images> getImages({int? page, int? perPage, String? pathUrl});

  Future<Uint8List?> getUint8ListFromUrl({required String imageUrl});
}
