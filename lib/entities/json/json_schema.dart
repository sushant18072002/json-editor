import 'dart:convert';

class JsonSchema {
  final Map<String, dynamic> schema;

  JsonSchema({required this.schema});

  factory JsonSchema.fromJson(dynamic json) {
    return JsonSchema(schema: json);
  }

  Map<String, dynamic> toJson() {
    return schema;
  }
}