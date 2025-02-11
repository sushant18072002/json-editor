import 'package:flutter/material.dart';

class LanguageSettingsPage extends StatelessWidget {
  static const String route = '/language_settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Language Settings'),
      ),
      body: Center(
        child: Text('Language Settings Page'),
      ),
    );
  }
}