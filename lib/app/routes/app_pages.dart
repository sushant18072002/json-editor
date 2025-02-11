import 'package:get/get.dart';
import 'package:json_editor/features/splash/presentation/pages/splash_page.dart';
import 'package:json_editor/features/home/presentation/pages/home_page.dart';
import 'package:json_editor/features/json_editor/presentation/pages/json_editor_page.dart';
import 'package:json_editor/features/json_comparison/presentation/pages/json_comparison_page.dart';
import 'package:json_editor/features/settings/presentation/pages/settings_page.dart';

import '../../features/json_editor/presentation/binding/json_editor_binding.dart';

abstract class AppPages {
  static const INITIAL = '/splash';

  static final routes = [
    GetPage(name: '/splash', page: () => SplashPage()),
    GetPage(name: '/home', page: () => HomePage()),
    GetPage(name: '/json_editor', page: () => JsonEditorPage(),binding: JsonEditorBinding()),
    GetPage(name: '/json_comparison', page: () => JsonComparisonPage()),
    GetPage(name: '/settings', page: () => SettingsPage()),
  ];
}