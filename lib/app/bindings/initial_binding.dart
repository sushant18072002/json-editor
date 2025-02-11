import 'package:get/get.dart';
import 'package:json_editor/core/network/api_provider.dart';
import 'package:json_editor/core/storage/local_storage.dart';
import 'package:json_editor/core/storage/secure_storage.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    // Initialize core dependencies
    Get.lazyPut(() => ApiProvider());
    Get.lazyPut(() => LocalStorage());
    Get.lazyPut(() => SecureStorage());
  }
}