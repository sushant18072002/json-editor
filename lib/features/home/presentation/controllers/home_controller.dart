import 'package:get/get.dart';
import 'package:json_editor/features/json_editor/presentation/pages/json_editor_page.dart';
import 'package:json_editor/features/json_comparison/presentation/pages/json_comparison_page.dart';
import 'package:json_editor/features/settings/presentation/pages/settings_page.dart';

class HomeController extends GetxController {
  void navigateToJsonEditor() {
    Get.toNamed(JsonEditorPage.route);
  }

  void navigateToJsonComparison() {
    Get.toNamed(JsonComparisonPage.route);
  }

  void navigateToSettings() {
    Get.toNamed(SettingsPage.route);
  }
}