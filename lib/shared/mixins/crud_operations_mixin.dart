import 'package:json_editor/entities/json/json_node.dart';

mixin CrudOperationsMixin {
  JsonNode addNode(JsonNode parentNode, String key, dynamic value) {
    if (parentNode.data is Map) {
      parentNode.data[key] = value;
    } else if (parentNode.data is List) {
      parentNode.data.add(value);
    }
    return parentNode;
  }

  JsonNode editNode(JsonNode node, dynamic newValue) {
    node.data = newValue;
    return node;
  }

  JsonNode deleteNode(JsonNode parentNode, dynamic key) {
    if (parentNode.data is Map) {
      parentNode.data.remove(key);
    } else if (parentNode.data is List) {
      parentNode.data.removeAt(key);
    }
    return parentNode;
  }
}