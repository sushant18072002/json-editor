import 'package:json_editor/entities/json/json_node.dart';

class DeleteNodeUseCase {
  JsonNode execute(JsonNode parentNode, dynamic key) {
    if (parentNode.data is Map) {
      parentNode.data.remove(key);
    } else if (parentNode.data is List) {
      parentNode.data.removeAt(key);
    }
    return parentNode;
  }
}