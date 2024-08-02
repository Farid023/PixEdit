import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_editor/core/constants/app_strings.dart';
import 'package:photo_editor/domain/repository/images_local_repository.dart';
import 'package:share_plus/share_plus.dart';

class ImagesLocalRepositoryImpl implements ImagesLocalRepository {
  @override
  Future<List<Uint8List>?> getLocalImages() async {
    try {
      final box = await Hive.openBox("imagesDB");
      List<dynamic>? images = box.get("images");
      if (images != null) {
        return List<Uint8List>.from(images);
      }
      return null;
    } catch (e, s) {
      log("getLocalImages $e");
      log("getLocalImages $s");
      return null;
    }
  }

  @override
  Future<void> saveImages(Uint8List imageBytes) async {
    try {
      List<Uint8List> images = [];

      final box = await Hive.openBox("imagesDB");
      List<dynamic>? allImages = box.get("images");

      if (allImages != null) {
        images = List<Uint8List>.from(allImages);
      }
      images.add(imageBytes);
      await box.put("images", images);
      log("Success to save LocalDB");
    } catch (e, s) {
      log("saveImages $s");
      log("saveImages $e");
    }
  }

  @override
  Future<Uint8List?> pickImage() async {
    try {
      ImagePicker imagePicker = ImagePicker();
      XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
      if (image == null) {
        return null;
      }
      Uint8List imageBytes = await image.readAsBytes();
      log(imageBytes.toString());
      return imageBytes;
    } catch (e) {
      log("$e");
      return null;
    }
  }

  @override
  Future<void> shareImage({required Uint8List imageBytes}) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/shared_image.jpg').create();
      await file.writeAsBytes(imageBytes);

      await Share.shareXFiles([XFile(file.path)],
          text: AppStrings.checkOutThisImage);
    } catch (e) {
      log('Error sharing image: $e');
    }
  }
}
