import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/constants/app_strings.dart';
import '../../../domain/repository/images_local_repository.dart';

class ImagesLocalRepositoryImpl implements ImagesLocalRepository {
  @override
  Future<List<String>?> getLocalImages() async {
    try {
      final box = await Hive.openBox("imagesDB");
      List<dynamic>? images = box.get("images");
      if (images != null) {
        return List<String>.from(images);
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
      List<String> images = [];
      final imagePath = await saveImageToStorage(imageBytes);
      if (imagePath != null) {
        final box = await Hive.openBox("imagesDB");
        List<dynamic>? allImages = box.get("images");
        if (allImages != null) {
          images = List<String>.from(allImages);
        }
        images.add(imagePath);
        await box.put("images", images);
        log("Success to save LocalDB");
      }
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

  Future<String?> saveImageToStorage(Uint8List imageBytes) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/${DateTime.now()}';
      final file = File(filePath);
      await file.writeAsBytes(imageBytes);
      log('Image saved in $filePath');
      return filePath;
    } catch (e) {
      log('Error when saving image: $e');
      return null;
    }
  }

  @override
  Future<bool> showRating() async {
    try {
      final inAppReview = InAppReview.instance;
      final available = await inAppReview.isAvailable();
      if (available) {
       await inAppReview.requestReview();
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> isFirstTimeOpen() async {
    const key = "FIRST_TIME_OPEN";
    try {
      final box = await Hive.openBox("imagesApp");
      dynamic isFirstTime = await box.get(key, defaultValue: true);
      if (isFirstTime != null && isFirstTime == true) {
        await box.put(key, false);
      }
      return isFirstTime;
    } catch (e) {
      throw Exception(e);
    }
  }
}
