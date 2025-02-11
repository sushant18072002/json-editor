import 'dart:convert';

import 'package:json_editor/core/storage/local_storage.dart';
import 'package:json_editor/entities/json/json_node.dart';

class JsonLocalDataSource {
  final LocalStorage _localStorage = LocalStorage();

  Future<void> saveJson(String key, JsonNode jsonNode) async {
    await _localStorage.saveString(key, jsonNode.toJson().toString());
  }

  Future<JsonNode?> loadJson(String key) async {
    final jsonString = _localStorage.getString(key);
    if (jsonString != null) {
      return JsonNode.fromJson(json.decode(jsonString));
    }
    return null;
  }
}