import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'theme/app_theme.dart';
import 'app/routes/app_pages.dart';

import 'app/controllers/theme_controller.dart';

void main() {
  Get.put(ThemeController());
  runApp(const TappApp());
}

class TappApp extends StatelessWidget {
  const TappApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TAPP - AI Transcription',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark, // Start with Dark Mode
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}

