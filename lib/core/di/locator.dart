



import 'package:get_it/get_it.dart';
import 'package:photo_editor/data/repository/local/images_local_repository_impl.dart';
import 'package:photo_editor/domain/repository/images_local_repository.dart';
import 'package:photo_editor/domain/repository/images_repository.dart';
import 'package:photo_editor/domain/usecase/get_images_use_case.dart';
import 'package:photo_editor/domain/usecase/get_local_images_use_case.dart';
import 'package:photo_editor/domain/usecase/get_u_int8_list_from_url_use_case.dart';
import 'package:photo_editor/domain/usecase/pick_image_use_case.dart';
import 'package:photo_editor/domain/usecase/save_to_local_db_use_case.dart';
import 'package:photo_editor/domain/usecase/share_image_use_case.dart';

import '../../data/repository/network/images_repository_impl.dart';

final locator = GetIt.instance;




Future<void> setupLocator () async{
  //Data layer
  locator.registerLazySingleton<ImagesRepositoryImpl>(()=> ImagesRepositoryImpl());
  locator.registerLazySingleton<ImagesLocalRepositoryImpl>(()=> ImagesLocalRepositoryImpl());

  //Domain layer
  locator.registerLazySingleton<ImagesRepository>(()=> ImagesRepositoryImpl());
  locator.registerLazySingleton<ImagesLocalRepository>(()=> ImagesLocalRepositoryImpl());
  //UseCases
  locator.registerLazySingleton<GetImagesUseCase>(()=> GetImagesUseCase(imagesRepository: locator()));
  locator.registerLazySingleton<GetLocalImagesUseCase>(()=> GetLocalImagesUseCase(imagesLocalRepository: locator()));
  locator.registerLazySingleton<SaveToLocalDbUseCase>(()=> SaveToLocalDbUseCase(imagesLocalRepository: locator()));
  locator.registerLazySingleton<GetUInt8ListFromUrlUseCase>(()=> GetUInt8ListFromUrlUseCase(locator()));
  locator.registerLazySingleton<PickImageUseCase>(()=> PickImageUseCase(imagesLocalRepository: locator()));
  locator.registerLazySingleton<ShareImageUseCase>(()=> ShareImageUseCase(imagesLocalRepository: locator()));





}