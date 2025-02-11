import 'dart:convert';

import 'package:json_editor/core/storage/local_storage.dart';
import 'package:json_editor/entities/json/json_schema.dart';

class SchemaRepositoryImpl {
  final LocalStorage _localStorage = LocalStorage();

  Future<void> saveSchema(String key, JsonSchema schema) async {
    await _localStorage.saveString(key, schema.toJson().toString());
  }

  Future<JsonSchema?> loadSchema(String key) async {
    final schemaString = _localStorage.getString(key);
    if (schemaString != null) {
      return JsonSchema.fromJson(json.decode(schemaString));
    }
    return null;
  }
}