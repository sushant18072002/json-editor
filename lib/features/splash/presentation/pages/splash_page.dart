import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:json_editor/features/splash/presentation/controllers/splash_controller.dart';

class SplashPage extends StatelessWidget {
  static const String route = '/splash';

  final SplashController _controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterLogo(size: 100),
      ),
    );
  }
}