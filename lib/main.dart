import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:photo_editor/core/di/locator.dart';
import 'package:photo_editor/core/navigation/pages.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  await setupLocator();
  await Hive.initFlutter();

  //TODO: Change Loading indicator
  //TODO: Change Success animation, may be show in Dialog --- completed
  //TODO: Add Onboard
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


void launchUrlAddress(Uri uri, bool inApp) async {
  try {
    if (await canLaunchUrl(uri)) {
      if (inApp) {
        await launchUrl(uri, mode: LaunchMode.inAppWebView);
      } else {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    }
  } catch (e) {
    log(e.toString());
    throw Exception(e);
  }
}
