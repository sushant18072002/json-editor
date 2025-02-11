import 'dart:convert';

import 'package:json_editor/entities/json/json_node.dart';

class JsonParserService {
  JsonNode parseJson(String jsonString) {
    return JsonNode.fromJson(json.decode(jsonString));
  }
}