import 'package:json_editor/entities/json/json_schema.dart';

class SchemaModel {
  final JsonSchema jsonSchema;

  SchemaModel({required this.jsonSchema});

  factory SchemaModel.fromJson(dynamic json) {
    return SchemaModel(jsonSchema: JsonSchema.fromJson(json));
  }

  Map<String, dynamic> toJson() {
    return jsonSchema.toJson();
  }
}