import 'package:get/get.dart';
import 'package:json_editor/app/theme/theme_manager.dart';

class SettingsController extends GetxController {
  final ThemeManager _themeManager = Get.find();

  void toggleTheme() {
    _themeManager.toggleTheme();
  }
}