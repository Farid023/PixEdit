import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../domain/models/images.dart';
import '../../presentation/screens/discover_images/cubit/discover_images_cubit.dart';
import '../../presentation/screens/discover_images/widgets/images_grid.dart';
import '../../presentation/screens/edit_image/edit_image_screen.dart';
import '../../presentation/screens/gallery/cubit/gallery_cubit.dart';
import '../../presentation/screens/gallery/gallery_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/image_view/cubit/image_view_cubit.dart';
import '../../presentation/screens/image_view/image_view_screen.dart';
import '../../presentation/widgets/bottom_nav_bar/cubit/nav_bar_cubit.dart';
import '../di/locator.dart';

class Pages {
  Pages._();

  static Widget get home => BlocProvider(
      create: (context) => NavBarCubit(), child: const HomeScreen());

  static Widget imageViewScreen(
          {Photo? item, Uint8List? imageBytes, String? imagePath}) =>
      BlocProvider(
        create: (context) =>
            ImageViewCubit(locator(), locator(), locator())..resetState(),
        child: ImageViewScreen(
            item: item, imageBytes: imageBytes, imagePath: imagePath),
      );

  static Widget get discoverImages => BlocProvider(
      create: (context) => DiscoverImagesCubit(locator())..getImages(),
      child: const DiscoverImagesView());

  static Widget get gallery => BlocProvider(
      create: (context) => GalleryCubit(locator(), locator())..getLocalImages(),
      child: const GalleryScreen());

  static Widget editImageScreen(
          {Photo? item, Uint8List? imageBytes, String? imagePath}) =>
      BlocProvider(
        create: (context) => ImageViewCubit(locator(), locator(), locator()),
        child: EditImageScreen(
            item: item, imageBytes: imageBytes, imagePath: imagePath),
      );
}
