import 'package:json_editor/entities/json/json_node.dart';

abstract class JsonRepository {
  Future<JsonNode?> loadJson(String key);
  Future<void> saveJson(String key, JsonNode node);
  Future<List<String>> getSavedKeys();
}
