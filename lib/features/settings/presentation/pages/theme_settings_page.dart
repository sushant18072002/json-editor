import 'package:flutter/material.dart';

class ThemeSettingsPage extends StatelessWidget {
  static const String route = '/theme_settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme Settings'),
      ),
      body: Center(
        child: Text('Theme Settings Page'),
      ),
    );
  }
}