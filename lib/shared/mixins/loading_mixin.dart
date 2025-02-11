import 'package:get/get.dart';

mixin LoadingMixin on GetxController {
  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  void setLoading(bool value) {
    _isLoading.value = value;
  }
}