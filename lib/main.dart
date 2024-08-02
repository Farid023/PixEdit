import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:photo_editor/core/di/locator.dart';
import 'package:photo_editor/core/navigation/pages.dart';

void main() async {
  await setupLocator();
  await Hive.initFlutter();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      scrollBehavior: const MaterialScrollBehavior()
          .copyWith(dragDevices: PointerDeviceKind.values.toSet()),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Pages.home,
    );
  }
}
