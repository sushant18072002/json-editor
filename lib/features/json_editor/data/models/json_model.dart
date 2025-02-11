import 'package:json_editor/entities/json/json_node.dart';

class JsonModel {
  final JsonNode jsonNode;

  JsonModel({required this.jsonNode});

  factory JsonModel.fromJson(dynamic json) {
    return JsonModel(jsonNode: JsonNode.fromJson(json));
  }

  Map<String, dynamic> toJson() {
    return jsonNode.toJson();
  }
}