import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'app/theme/app_theme.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() {
  configureUrl();
  runApp(
    GetMaterialApp(
      title: 'JSON Editor',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}

void configureUrl() {
  usePathUrlStrategy();
}