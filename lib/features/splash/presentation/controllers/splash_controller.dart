import 'package:get/get.dart';
import 'package:json_editor/app/routes/app_routes.dart';
import 'package:json_editor/core/storage/local_storage.dart';

class SplashController extends GetxController {
  final LocalStorage _localStorage = LocalStorage();

  @override
  void onInit() {
    super.onInit();
    _initializeApp();
  }

  void _initializeApp() async {
    await _localStorage.init();
    await Future.delayed(const Duration(seconds: 2)); 
    Get.offNamed(AppRoutes.HOME);
  }
}