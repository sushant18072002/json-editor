import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:json_editor/features/settings/presentation/controllers/settings_controller.dart';

class SettingsPage extends StatelessWidget {
  static const String route = '/settings';

  final SettingsController _controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Toggle Theme'),
            trailing: Switch(
              value: Get.isDarkMode,
              onChanged: (value) {
                _controller.toggleTheme();
              },
            ),
          ),
        ],
      ),
    );
  }
}