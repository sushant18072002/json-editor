import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AppLocalizations {
  static Map<String, String> _localizedStrings = {};

  static Future<void> load(String locale) async {
    String jsonString =
        await rootBundle.loadString('lib/app/theme/localization/$locale.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }

  static String translate(String key) {
    return _localizedStrings[key] ?? key;
  }
}

class LocalizationService extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': {
      'title': 'JSON Editor',
      'home': 'Home',
    },
    'es': {
      'title': 'Editor JSON',
      'home': 'Inicio',
    },
  };
}