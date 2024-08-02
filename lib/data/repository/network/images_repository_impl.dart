import 'dart:developer';
import 'dart:typed_data';

import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:photo_editor/core/constants/endpoints.dart';

import '../../../domain/models/images.dart';
import '../../../domain/repository/images_repository.dart';

class ImagesRepositoryImpl implements ImagesRepository {
  ImagesRepositoryImpl();

  final dio = Dio(BaseOptions(baseUrl: Endpoints.baseUrl, headers: {
    "Authorization": Endpoints.apiKey,
  }))
    ..interceptors.add(AwesomeDioInterceptor());

  @override
  Future<Images> getImages(
      {int? page = 1, int? perPage, String? pathUrl}) async {
    try {
      final response = await dio.get(pathUrl ?? "",
          queryParameters: {"page": page, "per_page": perPage ?? 10});

      if (response.statusCode == 200) {
        final images = Images.fromJson(response.data);
        return images;
      }

      throw Exception();
    } catch (e) {
      log("getImages $e");
      throw Exception(e);
    }
  }

  @override
  Future<Uint8List?> getUint8ListFromUrl({required String imageUrl}) async {
    try {
      final dio = Dio();
      final response = await dio.get(
        imageUrl,
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );


      if (response.statusCode == 200) {
       // log("repository"+Uint8List.fromList(response.data).toString());

       final Uint8List imageBytes =  Uint8List.fromList(response.data);
       log("imageBytes $imageBytes");
        return imageBytes;
      } else {
        log('Failed to load image. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('Exception occurred: $e');
      return null;
    }
  }
}
