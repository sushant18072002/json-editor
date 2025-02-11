import 'dart:convert';

import 'package:json_editor/core/network/api_provider.dart';
import 'package:json_editor/core/storage/local_storage.dart';
import 'package:json_editor/entities/json/json_node.dart';

import '../../features/json_editor/domain/repositories/json_repository.dart';

class JsonRepositoryImpl implements JsonRepository {
  final LocalStorage _localStorage;
  final ApiProvider apiProvider;

  JsonRepositoryImpl( this.apiProvider,this._localStorage){
    _localStorage.init();
  }

  @override
  Future<JsonNode?> loadJson(String key) async {
    try {
      final jsonString = await _localStorage.getString(key);
      if (jsonString != null) {
        final decoded = json.decode(jsonString);
        return JsonNode.fromJson(decoded);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to load JSON: $e');
    }
  }

  @override
  Future<void> saveJson(String key, JsonNode node) async {
    try {
      final jsonString = json.encode(node.toJson());
      await _localStorage.saveString(key, jsonString);
    } catch (e) {
      throw Exception('Failed to save JSON: $e');
    }
  }

  @override
  Future<List<String>> getSavedKeys() async {
    try {
      //return await _localStorage.getKeys();
      return [];
    } catch (e) {
      throw Exception('Failed to get saved keys: $e');
    }
  }
}
