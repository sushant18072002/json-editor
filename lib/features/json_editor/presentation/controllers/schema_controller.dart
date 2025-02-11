import 'package:get/get.dart';
import 'package:json_editor/entities/json/json_schema.dart';

class SchemaController extends GetxController {
  final Rx<JsonSchema?> _jsonSchema = Rx<JsonSchema?>(null);

  JsonSchema? get jsonSchema => _jsonSchema.value;

  void setSchema(JsonSchema schema) {
    _jsonSchema.value = schema;
  }
}