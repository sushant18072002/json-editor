import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:json_editor/features/home/presentation/controllers/home_controller.dart';

class HomePage extends StatelessWidget {
  static const String route = '/home';

  final HomeController _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _controller.navigateToJsonEditor,
              child: Text('Open JSON Editor'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _controller.navigateToJsonComparison,
              child: Text('Compare JSON Files'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _controller.navigateToSettings,
              child: Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}